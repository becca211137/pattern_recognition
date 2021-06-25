clear;
N=250; 
theta1 = linspace(-180,180, N)*pi/360; 
r = 8 ;
x1 = -5 + r*sin(theta1)+randn(1,N); 
y1 = r*cos(theta1)+randn(1,N);   
x2 = 5 + r*sin(theta1)+randn(1,N); 
y2 = -r*cos(theta1)+randn(1,N); 


% set ans 0/1 class
oi = [x1.' y1.' zeros(250,1)+1 ; x2.' y2.' zeros(250,1)+1 ];
ans = [zeros(250,1) ;zeros(250,1)+1 ];
% rearrange
total=500;
train_total=400;
test_total = 100;
r = randperm(total);
oi(:,1) = oi(r,1);
oi(:,2) = oi(r,2);
ans = ans(r);

test=oi([train_total+1 :total], :);
test_ans = ans([train_total+1 :total],:);

% set initial value
wij = [0.749120729449102,0.127013893617675,0.113789807451064,0.492415695453145;0.147735486618356,0.916921352125118,0.960227492817496,0.361313401952203;0.00288774509561229,0.672121707253300,0.119383120967445,0.470000490547994];
wjk =[0.0587797688209679;0.330011701173118;0.264520477657796;0.245917666364952;0.947676359396337]; 

rate = 0.0001;
C  = 0.0025;
max_iter = 1000;
iter = 1;
sj = [];
sk = [];
oj = [];
ok = [];
% last result
accuracy=[];
e=[];
while iter<=max_iter 
    error = 0;
    for i = 1:1:train_total
        % foward
        sj = oi(i,:)*wij;
        oj = [sigmf(sj,[1,0]) 1];        
        sk = oj*wjk;
        ok= round(sigmf(sk,[1,0]));
        prev_wjk = wjk;
        % update w2         
        f = sigmf(sk,[1,0]);
        for j=1:5
            wjk(j,1) =  wjk(j,1) + rate * (ans(i)-ok)* f * (1-f) * oj(j);
        end        
        % update w1
        for ii = 1:3
            for jj = 1:4
                f = sigmf(sj(jj),[1,0]);
                fk = sigmf(sk,[1,0]);
                sum =  (ans(i,1) - ok ) * fk * (1-fk) * prev_wjk(jj,1);
                wij(ii,jj) = wij(ii,jj) + rate*  sum * f * (1-f) *prev_wjk(jj) * f * (1-f) * oi(i,ii);
            end
        end
        error = error + (ans(i) - ok).^2/2;
    end
    e(iter) = error/train_total;
    
    if error < C
        break;
    end
    acc=0;
    for t=1:test_total
        sj = test(t,:)*wij;
        oj = [sigmf(sj,[1,0]) 1];
        sk = oj*wjk;
        ok= round(sigmf(sk,[1,0]));
        prev_wjk = wjk;
        if ok== test_ans(t)
            acc = acc+1;
        end
    end
    acc = acc/test_total;
    accuracy(iter) = acc;
    iter = iter + 1;
end
figure(1);
plot(e);
figure(2);
plot(accuracy);
for ix=-50:50 
    for iy=-50:50
        dx=0.3*(ix-1); 
        dy=0.3*(iy-1);
        oi=[dx dy 1];
        sj = oi*wij;
        oj = sigmf(sj,[1,0]);     
        oj = [oj 1];
        sk = oj*wjk;
        ok= round(sigmf(sk,[1,0]));        
        if ok==1
            figure(3);
            axis([-15 15 -15 15]);
            plot(dx,dy, 'g .');
            hold on;
        elseif ok==0
            figure(3);
            axis([-15 15 -15 15]);
            plot(dx,dy, 'r .');
            hold on;
        end        
    end
end