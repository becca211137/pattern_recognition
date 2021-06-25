
size_train = 60000;
size_test = 10000;
num_train = 60000;
num_test = 10000;

[trInput,trDes,tsInput,tsDes,dim,n_class]=Data_create(num_train,num_test);
%5000,1000 (tr,ts)
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
figure
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
figure
plotconfusion(tpDes,tsOut)

% show training images
for i=1:10
    for j=1:15
        %img(28*(i-1)+1:28*i,28*(j-1)+1:28*j)=Images(:,:,num(i,j));
        img(28*(i-1)+1:28*i,28*(j-1)+1:28*j)=trInput(:,:,(i-1)*15+j);
    end
end

figure;
imshow(uint8(256*img));

% show testing result
pos = zeros(150,2);
for i=1:150
    pos(i,2) = 43*ceil(i/15)+3;
    if mod(i,15)==0
        pos(i,1) = 257;
    else
        pos(i,1) = 5 + (mod(i,15)-1)*28;
    end
end
pos2 = pos;
pos2(:,1) = pos2(:,1) +8;

img = [];
out_desired = tsDes(1:150);
out_predict = tpOut(1:150);
out_predict = out_predict-1;
for ii = 1:150
    if mod(ii,15) == 0
        img((floor(ii/15)-1)*15+(ceil(ii/15)*28 - 27):(floor(ii/15)-1)*15+ceil(ii/15)*28, 253:280) = tsInput(:,:,:,ii);
    else
        img(floor(ii/15)*15+(ceil(ii/15)*28 - 27):floor(ii/15)*15+ceil(ii/15)*28, (mod(ii,15)*28-27):mod(ii,15)*28) = tsInput(:,:,:,ii);
    end    
end

RGB = insertText(img,pos,out_desired,'FontSize',10,'TextColor','c', 'BoxOpacity' ,0,'BoxColor' ,'black','AnchorPoint','LeftBottom');
RGB2 = insertText(img,pos2,out_predict,'FontSize',10,'TextColor','g', 'BoxOpacity' ,0,'BoxColor' ,'black','AnchorPoint','LeftBottom');

figure;
imshowpair(RGB, RGB2);


