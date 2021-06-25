clear;
% set data1
mu = [0;0];
sigma = [1 0; 0 1];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
figure(1);
plot(r(:,1),r(:,2),'+');
hold on;
oi = [r];
% set data2
mu = [14;0];
sigma = [1 0; 0 4];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
plot(r(:,1),r(:,2),'o');
hold on;
oi = [ oi ;r];
% set data3
mu = [7;14];
sigma = [4 0; 0 1];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
plot(r(:,1),r(:,2),'d');
hold on;
oi = [ oi ;r];
% set data4
mu = [7;7];
sigma = [1 0; 0 1];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
plot(r(:,1),r(:,2),'s');
hold on;
oi = [ oi ;r ];
% set ans
ans = [zeros(150,1)+1 ;zeros(150,1)+2 ;zeros(150,1)+3; zeros(150,1)+4];
% rearrange
total=600;
train_total=total*0.8;
test_total = total*0.2;
r = randperm(total);
oi(:,1) = oi(r,1);
oi(:,2) = oi(r,2);
ans = ans(r);
t=[1:total];
final_ans = zeros(600,4);
for i=1:600
    final_ans(i,ans(i)) = 1;
end
test=oi([train_total+1 :total], :);
test_ans = final_ans([train_total+1 :total],:);


net = feedforwardnet(5);
net.layers{2}.size = 4;
net.inputs{1}.size=2;
net.layers{1}.transferFcn = 'logsig';
net.layers{2}.transferFcn = 'logsig';
net.divideFcn = 'dividetrain';
net.trainFcn='traingd';
net=train(net,oi.',final_ans.');




