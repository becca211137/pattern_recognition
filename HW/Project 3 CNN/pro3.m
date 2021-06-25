train_total = 60000;
test_total = 10000;

dim = 10;
n_class = 10;
trI = loadMNISTImages('train-images.idx3-ubyte');
trD = loadMNISTLabels('train-labels.idx1-ubyte');
tsI = loadMNISTImages('t10k-images.idx3-ubyte');  
tsD = loadMNISTLabels('t10k-labels.idx1-ubyte');
trInput = zeros(28, 28, 1, train_total);
trDes = zeros(train_total, 1);
for i = 1:train_total
    trInput(:,:,1,i) = trI(:,:,i);
    trDes(i,1) = trD(i,1);
end
tsInput = zeros(28, 28, 1, test_total);
tsDes = zeros(test_total, 1);
for i = 1:test_total
    tsInput(:,:,1,i) = tsI(:,:,i);
    tsDes(i,1) = tsD(i,1);
end

trT = categorical(trDes);
tsT = categorical(tsDes);

% design model
layers = [
    imageInputLayer([28 28 1],'Name','input')    
    convolution2dLayer(3,8,'Padding','same','Name','conv_1')
    batchNormalizationLayer('Name','norm_1')
    reluLayer('Name','relu_1')    
    maxPooling2dLayer(2,'Stride',2,'Name','Mpool_1')    
    convolution2dLayer(3,16,'Padding','same','Name','conv_2')
    batchNormalizationLayer('Name','norm_2')
    reluLayer('Name','relu_2')    
    maxPooling2dLayer(2,'Stride',2,'Name','Mpool_2') 
    fullyConnectedLayer(10,'Name','fc')
    softmaxLayer('Name','softmax')
    classificationLayer('Name','output')];
lgraph = layerGraph(layers);
figure(4);
plot(lgraph);

options = trainingOptions(...
    'sgdm',...
    'MaxEpochs', 5, ...
    'MiniBatchSize', 128,...
    'InitialLearnRate', 0.1,...
    'ExecutionEnvironment', 'auto',...
    'Verbose',false, ...
    'Plots', 'training-progress');

rng('default');
net = trainNetwork(trInput,trT,layers,options);
tsOutput= classify(net,tsInput);
tsOutput=tsOutput(1:numel(tsT));
accuracy = sum(tsOutput == tsT)/numel(tsT);
% categorical to matrix
tsOut=zeros(n_class,size(tsDes,1));
tpOut=grp2idx(tsOutput);
tpDes=zeros(n_class,size(tsDes,1));
for i=1:size(tsDes,1)
    tsOut(tpOut(i),i)=1;
    tpDes(tsDes(i)+1,i)=1;
end
% ConfMat
[Mout,Iout]=max(tsOut);%value,index
[Mdes,Ides]=max(tpDes);
ConfMat=zeros(n_class,n_class);
c=0;%check how many wrong
for i=1:size(tsDes,1)
    if(Ides(i)~=Iout(i))
        c=c+1;
    end
    % ConfMat(i,j) num of should be i, but be j
    ConfMat(Ides(i),Iout(i))=ConfMat(Ides(i),Iout(i))+1;
end
figure(1);
plotconfusion(tpDes,tsOut);

% show training images
img=[];
for i=0:9
    for j=0:14
        img(28*i+1:28*(i+1),28*j+1:28*(j+1))=trInput(:,:,i*15+j+1);
    end
end
figure(2);
imshow(img);
title('train image');

% show testing result
position = zeros(150,2);
for i=1:150
    position(i,2) = 43*ceil(i/15)+3;
    if mod(i,15)==0
        position(i,1) = 257;
    else
        position(i,1) = 5 + (mod(i,15)-1)*28;
    end
end
position2 = position;
position2(:,1) = position2(:,1)+8;
img = [];
ans_desired = tsDes(1:150);
ans_output = tpOut(1:150)-1;
for i = 1:150
    if mod(i,15) == 0
        img((floor(i/15)-1)*15+(ceil(i/15)*28 - 27):(floor(i/15)-1)*15+ceil(i/15)*28, 253:280) = tsInput(:,:,:,i);
    else
        img(floor(i/15)*15+(ceil(i/15)*28 - 27):floor(i/15)*15+ceil(i/15)*28, (mod(i,15)*28-27):mod(i,15)*28) = tsInput(:,:,:,i);
    end    
end
RGB = insertText(img,position,ans_desired,'FontSize',10,'TextColor','c', 'BoxOpacity' ,0,'BoxColor' ,'black','AnchorPoint','LeftBottom');
RGB2 = insertText(img,position2,ans_output,'FontSize',10,'TextColor','g', 'BoxOpacity' ,0,'BoxColor' ,'black','AnchorPoint','LeftBottom');
figure(3);
imshowpair(RGB, RGB2);
title('test image, green-desired number, purple-real output');