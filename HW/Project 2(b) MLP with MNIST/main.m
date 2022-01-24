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

% 
% show picture
% num = [1:150];
% for tmp = 1:150
%     if mod(tmp,15) == 0
%         img( (ceil(tmp/15) *28 - 27) : ceil(tmp/15) *28, 393:420) = reshape(image(:,tmp),28,28);
%     else
%         img( (ceil(tmp/15) *28 - 27) : ceil(tmp/15) *28,  (mod(tmp,15)*28-27) : mod(tmp,15)*28) = reshape(image(:,tmp),28,28);
%     end
% end
% imshow(img);

% read label
filename = 't10k-labels.idx1-ubyte';
fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);
magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);
numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');
labels = fread(fp, inf, 'unsigned char');
assert(size(labels,1) == numLabels, 'Mismatch in label count');
fclose(fp);

total=1000;
train_total=total*0.8;
test_total = total*0.2;
oi = [image.' zeros(num_image,1)+1];
test=oi([train_total+1 :total], :);
test_ans = labels([train_total+1 :total]);

% set initial value
node_i = 784;
node_j=5;
node_k=1;
wij = rand(node_i+1,node_j).*2-1;
wjk = rand(node_j+1,1).*2-1; 
% wij = [-0.852010460846124,0.965670402787902,-0.691260389041455,0.516224862654837,0.371071417495074;0.368192133924018,-0.195632029555031,-0.237309591111056,0.742222243830778,-0.411702732464301;-0.195223334607676,0.241343894399157,-0.677732056301278,-0.298446510228215,0.0612586077137711];
% wjk = [0.664846772570368,-0.280787364055529,-0.951131967899252,-0.0842273322912663;0.194980383745159,0.116638399738594,-0.419629469738546,-0.519043206335831;-0.329377338589508,0.485090731403878,-0.364958834201547,0.527795888572957;-0.401549953333787,-0.151330432748619,0.307380267932950,0.518654766262193;-0.0948149168613519,-0.141288422847590,0.913871848141368,0.481296129957229;-0.154708693559075,-0.750254482560374,0.871461745569761,0.487376682974652];
i_wij=wij;
i_wjk=wjk;

rate = 0.001;
C  = 0.005;
max_iter = 100;
iter = 1;
sj = [];
sk = [];
oj = [];
ok = [];
% last result
accuracy=[];
e=[];
% regulize
oi(:,1) = (oi(:,1)-mean(oi(:,1)) ) / std(oi(:,1));
oi(:,2) = (oi(:,2)-mean(oi(:,2)) ) / std(oi(:,2));
while iter<=max_iter 
    disp(iter);
    error = 0;
    for i = 1:1:train_total
        % foward
        sj = oi(i,:)*wij;
        oj = [sigmf(sj,[1,0]) 1];
        sk = oj*wjk;
        ok= ceil(10*(sigmf(sk,[1,0])));
        prev_wjk = wjk;
        
        % update w2         
        f = sigmf(sk,[1,0]);
        for j=1:node_j
            wjk(j,1) =  wjk(j,1) + rate * (ans(i)-ok)* f * (1-f) * oj(j);
        end        
        % update w1
        for ii = 1:node_i
            for jj = 1:node_j
                f = sigmf(sj(jj),[1,0]);
                fk = sigmf(sk,[1,0]);
                sum =  (ans(i,1) - ok ) * fk * (1-fk) * prev_wjk(jj,1);
                wij(ii,jj) = wij(ii,jj) + rate*  sum * f * (1-f) *prev_wjk(jj) * f * (1-f) * oi(i,ii);
            end
        end
          
        error = error + (labels(i) - ok).^2/2;
        
        
    end
    e(iter) = error/train_total;
    
    if error < C
        break;
    end
%     acc=0;
%     for t=train_total+1:train_total+test_total
%         sj = oi(t,:)*wij;
%         oj = [sigmf(sj,[1,0]) 1];
%         sk = oj*wjk;
%         ok= ceil(10*(sigmf(sk,[1,0])));
%         if ok == labels(t)
%             acc = acc+1;
%         end
% 
%     end
%     acc = acc/test_total;
%     accuracy(iter) = acc;
    iter = iter + 1;
end
figure(1);
plot(e);
% figure(2);
% plot(accuracy);



