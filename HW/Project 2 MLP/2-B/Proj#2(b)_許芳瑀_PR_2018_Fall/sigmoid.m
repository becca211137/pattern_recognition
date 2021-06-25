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
train_label = labels;


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
test_label = labels;

%total
train_total = 1000;  
test_total = 1000;
node_j = 250;  
[node_i,temp] = size(train_data);  
node_o = 10;  
max_iter = 100; 
rate = 0.15; 
wij = rand(node_i + 1, node_j); 
wjk = rand(node_j + 1, node_o);  

A = eye(node_o);  
train_hit = [];  
train_error=[];
%%Training  
t1 = cputime;
for iter = 1:max_iter
    train_error(iter) = 0;
    train_hit(iter) = 0;
       %fprintf('Iteration %d\n', iter);   
    for index = 1:train_total  
         % Propogate forward  
         oi = [train_data(:, index); 1];  
         sj = sigmf(wij' * oi, [0.05, 0]);  
         oj = [sj; 1];  
         sk = sigmf(wjk' * oj, [0.05, 0]); 
         [temp, m] = max(sk);  
         if m == (train_label(index) + 1)  
           train_hit(iter) = train_hit(iter) + 1;  
         else
             train_error(iter) =  train_error(iter) +1;            
         end  
         % Propogate backward  
         sum2 = sk - A(:, train_label(index) + 1);  
         sum1 = wjk * (sum2 .* sk .* (1 - sk));  
         sum0 = sum1(1:node_j);  
         % Update weight  
         wjk = wjk - rate * oj * (sum2 .* sk .* (1 - sk))';  
         wij = wij - rate * oi * (sum0 .* sj .* (1 - sj))';  
       end   
end  
t2 = cputime;
time = t2-t1;
errortrain = train_error / train_total;
figure(3);
plot([1:100],errortrain);
xlabel('iteration');
ylabel('error rate'); 
title(['cputime = ',num2str(time)]);
accuracytrain = (train_hit /  train_total);
% test
test_hit = 0;  
test_ans = [];
for i = 1:test_total   
    oi = [test_data(:, i); 1];  
    oj = [sigmf(wij' * oi, [0.05, 0]); 1];  
    sk = sigmf(wjk' * oj, [0.05, 0]);  
    [temp, m] = max(sk);   
    test_ans(i) = m;
    if (m == test_label(i) + 1)  
        test_hit = test_hit + 1;  
    end 
end  
accuracytest = (test_hit /  test_total )*100;
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
% test image
ans_output = test_ans(1:100);
ans_desired = test_label(1:100);
p = zeros(2,1);
position = zeros(100,2);
for i=1:100
    position(i,2) = 38*ceil(i/10)+3;
    if mod(i,10)==0
        position(i,1) = 257;
    else
        position(i,1) = 5 + (mod(i,10)-1)*28;
    end
end
% for out ans
position2 = position;
position2(:,1)  = position2(:,1) +8;

img=zeros(400,280);
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

c_matrix = confusionmat(test_ans,test_label(1:test_total)+1);
con = 100*c_matrix./test_total;
