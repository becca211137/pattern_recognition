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
[NODE_I,train_total]= size(train_data);
r = randperm(train_total);
train_data = train_data.';
% train_data = train_data(r,:);
% train_label = train_label(r);

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
test_data= image.';
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



NODE_J = 250;  
out = 10;  
max_iter = 100;  
f = 0.01; % Scaling factor in sigmoid function  
rate = 0.1; % Learning rate  
%%Initialize the weights from Uniform(0, 1)  
w1 = rand(NODE_I + 1, NODE_J); % Weight for layer-1, including bias unit  
w2 = rand(NODE_J + 1, out); % Weight for layer-2. including bias unit  
A = eye(out);  
train_hit = zeros(max_iter, 1);  
train_total=1000;
test_total=1000;
error=[];
time = cputime;
train_hit = [];
train_error = [];
%%Training  
for iter = 1:max_iter 
    train_hit(iter) = 0; 
    train_error(iter) = 0;
    
    fprintf('Iteration %d\n', iter); 
    for index = 1:train_total      
        % Propogate forward  
        oi = [train_data(index,:) 1];  
        sj = sigmf(oi * w1, [f, 0]);  
        ok = [sj 1];  
        sk = sigmf(ok * w2, [f, 0]);  
        % record error
        
        [temp, ans] = max(sk);  
        if (ans == train_label(i) + 1)  
            train_hit(iter) = train_hit(iter) + 1;  
        else
            train_error(iter) = train_error(iter) + 1;
        end  
        % Propogate backward 
        back_j = w2 * ((sk - A(:, train_label(index) + 1).').' .* sk .* (1 - sk));  
        back_j = back_j(1:NODE_J);  
%         e1 = w1 * back_j.';  
        % Update weight  
        w2 = w2 - rate * ok.' * ((sk - A(:, train_label(index) + 1).') * sk.' * (1 - sk));  
        w1 = w1 - rate * oi.' * (back_j * sj.' * (1 - sj));  
    end  
%%Check training error  
     
  

end  
cpu_time = cputime-time;
accuracytrain = (train_hit /  train_total);
error_train = train_error / train_total;
test_hit = 0;  
test_ans=[];
for i = 1:test_total  
    oi = [test_data(i,:) 1];  
    sj = sigmf(oi * w1, [f, 0]);  
    ok = [sj 1];  
    sk = sigmf(ok * w2, [f, 0]);  
    [temp, ans] = max(sk); 
    test_ans(i) = ans;
    if (ans == test_label(i) + 1)  
        test_hit = test_hit + 1;  
    end 
end  
accuracytest = (test_hit / test_total);
fprintf('\ntest set Accuracy : %f\n', accuracytest);
% % show train image
% train_data = train_data.';
% img=[];
% for tmp = 1:100
% %     disp(tmp);
%     if mod(tmp,10) == 0
%         img( (floor(tmp/10)-1)*10+(ceil(tmp/10) *28 - 27) : (floor(tmp/10)-1)*10+ceil(tmp/10) *28, 253:280) = reshape(train_data(:,tmp),28,28);
%     else
%         img( floor(tmp/10)*10+(ceil(tmp/10) *28 - 27) : floor(tmp/10)*10+ceil(tmp/10) *28,  (mod(tmp,10)*28-27) : mod(tmp,10)*28) = reshape(train_data(:,tmp),28,28);
%     end
%     
% end
% figure(1);
% imshow(img);
% title('train image');
% % test image
% value = test_ans[1:100];
% for x=1:10
%     for y=1:10
%         position(x,y) =3+
%     end
% end
% img=[];
% for tmp = 1:100
% %     disp(tmp);
%     if mod(tmp,10) == 0
%         img( (ceil(tmp/10) *28 - 27) : ceil(tmp/10) *28, 253:280) = reshape(test_data(:,tmp),28,28);
%     else
%         img( (ceil(tmp/10) *28 - 27) : ceil(tmp/10) *28,  (mod(tmp,10)*28-27) : mod(tmp,10)*28) = reshape(test_data(:,tmp),28,28);
%     end
%     
% end
% figure(2);
% imshow(img);
% title('test image');

