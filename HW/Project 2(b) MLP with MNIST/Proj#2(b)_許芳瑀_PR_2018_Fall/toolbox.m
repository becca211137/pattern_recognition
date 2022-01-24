% % train data
filename = 'train-images.idx3-ubyte';
fp = fopen(filename,'r');
magic = fread(fp,1, 'int32',0, 'ieee-be');
num_image = fread(fp,1, 'int32',0, 'ieee-be');
num_row = fread(fp,1, 'int32',0, 'ieee-be');
num_col = fread(fp,1, 'int32',0, 'ieee-be');
image = fread(fp, inf, 'unsigned char');
image = reshape(image, num_col, num_row, num_image);
image = permute(image,[2 1 3]);
fclose(fp);
image = reshape(image, size(image, 1) * size(image, 2), size(image, 3));
image = double(image) / 255;
train_data = image;
train_size = size(train_data); 

% % train label
filename = 'train-labels.idx1-ubyte';
fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);
magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);
numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
labels = fread(fp, inf, 'unsigned char');
assert(size(labels,1) == numLabels, 'Mismatch in label count');
fclose(fp);
train_label = labels+1;


% test data
filename = 't10k-images.idx3-ubyte';
fp = fopen(filename,'r');
magic = fread(fp,1, 'int32',0, 'ieee-be');
num_image = fread(fp,1, 'int32',0, 'ieee-be');
num_row = fread(fp,1, 'int32',0, 'ieee-be');
num_col = fread(fp,1, 'int32',0, 'ieee-be');
image = fread(fp, inf, 'unsigned char');
image = reshape(image, num_col, num_row, num_image);
image = permute(image,[2 1 3]);
fclose(fp);
image = reshape(image, size(image, 1) * size(image, 2), size(image, 3));
image = double(image) / 255;
test_data= image;
test_size = size(test_data); 
[temp,test_total] = size(test_data);
% test label
filename = 't10k-labels.idx1-ubyte';
fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);
magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);
numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
labels = fread(fp, inf, 'unsigned char');
assert(size(labels,1) == numLabels, 'Mismatch in label count');
fclose(fp);
test_label = labels+1;

%total
train_total = 60000;  
test_total = 10000;

x = train_data(:,[1:train_total]);
t=zeros(10,train_total);

for i=1:train_total
    t(train_label(i),i)=1;
end

setdemorandstream(391418381);
net = patternnet(300);
t1=cputime;
% train
[net,tr] = train(net,x,t);
nntraintool;
plotperform(tr);
t2=cputime;
disp(['cputime = ',num2str(t2-t1)]);


%test
testX = test_data(:,[1:test_total]);
testT=zeros(10,test_total);

for i=1:test_total
    t(test_label(i),i)=1;
end
testY = net(testX);
testClasses = vec2ind(testY);


acc=0;
for i=1:test_total
    if testClasses(i)==test_label(i)
        acc=acc+1;
    end
end


% show train image
img=[];
for tmp = 1:100
%     disp(tmp);
    if mod(tmp,10) == 0
        img( (floor(tmp/10)-1)*10+(ceil(tmp/10) *28 - 27) : (floor(tmp/10)-1)*10+ceil(tmp/10) *28, 253:280) = reshape(train_data(:,tmp),28,28);
    else
        img( floor(tmp/10)*10+(ceil(tmp/10) *28 - 27) : floor(tmp/10)*10+ceil(tmp/10) *28,  (mod(tmp,10)*28-27) : mod(tmp,10)*28) = reshape(train_data(:,tmp),28,28);
    end
    
end
figure(1);
imshow(img);
title('train image');

% for out ans
position = zeros(100,2);
for i=1:100
    position(i,2) = 38*ceil(i/10)+3;
    if mod(i,10)==0
        position(i,1) = 257;
    else
        position(i,1) = 5 + (mod(i,10)-1)*28;
    end
end
position2 = position;
position2(:,1)  = position2(:,1) +8;
img=zeros(400,280);
ans_desired=test_label(1:100);
ans_output=testClasses(1:100);
for tmp = 1:100
%     disp(tmp);
    if mod(tmp,10) == 0
        img( (floor(tmp/10)-1)*10+(ceil(tmp/10) *28 - 27) : (floor(tmp/10)-1)*10+ceil(tmp/10) *28, 253:280) = reshape(test_data(:,tmp),28,28);
    else
        img( floor(tmp/10)*10+(ceil(tmp/10) *28 - 27) : floor(tmp/10)*10+ceil(tmp/10) *28,  (mod(tmp,10)*28-27) : mod(tmp,10)*28) = reshape(test_data(:,tmp),28,28);
    end
    
end

RGB = insertText(img,position,ans_desired,'FontSize',11,'TextColor','r', 'BoxOpacity' ,0,'BoxColor' ,'black','AnchorPoint','LeftBottom');
RGB2 = insertText(img,position2,ans_output,'FontSize',11,'TextColor','y', 'BoxOpacity' ,0,'BoxColor' ,'black','AnchorPoint','LeftBottom');

figure(2);
imshowpair(RGB, RGB2);
title('test image, green-desired number, purple-real output');

