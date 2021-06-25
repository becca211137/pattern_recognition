% question 2
% train 400, test 100
N=250; 
theta1 = linspace(-180,180, N)*pi/360; 
r = 8 ;
x1 = -5 + r*sin(theta1)+randn(1,N); 
y1 = r*cos(theta1)+randn(1,N);   
x2 = 5 + r*sin(theta1)+randn(1,N); 
y2 = -r*cos(theta1)+randn(1,N); 

% set train data
train_total = 400;
test_total = 100;
train_x = [ x1(1:200) x2(1:200) ];
train_y = [y1(1:200) y2(1:200) ];
z=zeros(1,200);
z1=z+1;
train_ans = [ z z1 ];
temp = randperm(400);
train_x = train_x(temp);
train_y = train_y(temp);
train_ans = train_ans(temp);
% set test data
test_x = [ x1(201:250) x2(201:250) ];
test_y = [y1(201:250) y2(201:250) ];
z=zeros(1,50);
z1=z+1;
test_ans = [z z1];
temp = randperm(100);
test_x = test_x(temp);
test_y = test_y(temp);
test_ans = test_ans(temp);
% set initial value
w1 = rand(2,3);
w2 = rand(1,3);
% init_w1=w1;
% init_w2 = w2;
% w1 = [0.9292 0.7291 0.5612; 0.0242 0.4663 0.9845];
% w2= [0.847 0.9767 0.3449];
rate = 0.0001;
C  = 0.005;
max_iter = 1000;
iter = 1;
s1 = [];
s2 = [];
o1 = [];
o2 = [];
accuracy=[];
e=[];

while iter<=max_iter 
    error = 0;
    for i = 1:1:400
        % foward
        s1(1) = train_x(i)*w1(1,1) + train_y(i)*w1(1,2) + w1(1,3);
        s1(2) = train_x(i)*w1(2,1) + train_y(i)*w1(2,2) + w1(2,3);
        o1 = sigmf(s1,[1,0]);
        o1 = [o1 1];
        s2 = o1(1)*w2(1) + o1(2)*w2(2) + w2(3);
        o2(i)= sigmf(s2,[1,0]);
        o2(i) = round(o2(i));
        prev_w2 = w2;
        % update w2 
         j=[1:3];
         f = sigmf(s2,[1,0]);
        w2(j) = w2(j) + rate * (train_ans(i)-o2(i)) * f * (1-f) * o1(j);
        % update w1
        o = [train_x(i) train_y(i) 1];
        for ii = 1:3
            for jj = 1:2
                f = sigmf(s2,[1,0]);
                w1(jj,ii) = w1(jj,ii) + rate*  (train_ans(i)-o2(i)) * f * (1-f) *prev_w2(jj) * f * (1-f) * o(ii);
            end
        end
    error = error + (train_ans(i) - o2(i)).^2;
    end
    iter = iter + 1;
    error = error / (2*400);
    e(iter) = error;
    if error < C
        break;
    end
    acc=0;
    for t=1:100
        s1(1) = test_x(t)*w1(1,1) + test_y(t)*w1(1,2) + w1(1,3);
        s1(2) = test_x(t)*w1(2,1) + test_y(t)*w1(2,2) + w1(2,3);
        o1 = sigmf(s1,[1,0]);
        o1 = [o1 1];
        s2 = o1(1)*w2(1) + o1(2)*w2(2) + w2(3);
        o2(t)= sigmf(s2,[1,0]);
        o2(t) = round(o2(t));
        if o2(t) == test_ans(t)
            acc = acc+1;
        end
        acc = acc/100;
        
    end
    
   accuracy(iter) = acc;
end

figure(1);
plot(e);
figure(2);
plot(accuracy);

