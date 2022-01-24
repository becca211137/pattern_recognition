% Q1 2hidden layer 20/10 hidden nodes
clear;
i=[0:96];
theta_i = i * pi / 16;
theta_j = i * pi / 16;
r_i = 6.5 .* (104 - i) / 104;
r_j = 6.5 .* (104 - i) / 104;

N=250; 
theta1 = linspace(-180,180, N)*pi/360; 
r = 8 ;
x1 = r_i .* sin(theta_i);
y1 = r_i .* cos(theta_i);
x2 = -x1;
y2 = -y1;

% set ans 0/1 class
oi = [x1.' y1.' zeros(97,1)+1 ; x2.' y2.' zeros(97,1)+1 ];
ans = [zeros(97,1) ;zeros(97,1)+1 ];
% rearrange
total=194;
train_total=160;
test_total = 34;
r = randperm(total);
oi(:,1) = oi(r,1);
oi(:,2) = oi(r,2);
ans = ans(r);

test=oi([train_total+1 :total], :);
test_ans = ans([train_total+1 :total],:);

% set initial value
num_j = 20;
num_k = 10;
wij = rand(3,20);
wjk = rand(21,10);
wkl = rand(11, 1);
i_wij = wij;
i_wjk = wjk;
i_wkl = wkl;
rate = 0.001;
C  = 0.01;
max_iter = 15000;
iter = 1;
sj = [];
sk = [];
sl = [];
oj = [];
ok = [];
ol = [];

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
        oj = [sj 1];
        sk = oj*wjk;
        ok= [sk 1];
        sl = ok*wkl;
        ol = round(sigmf(sl,[1,0]));
        prev_wjk = wjk;
        prev_wkl = wkl;
        % update wkl        
        f = sigmf(sl,[1,0]);
        for kk=1:num_k+1
            wkl(kk,1) =  wkl(kk,1) + rate * (ans(i)-ol)* f * (1-f) * ok(kk);
        end
        
        % update wjk
        for jj = 1:num_j+1
            for kk = 1:num_k
                f = sigmf(sk(kk),[1,0]);
                fl = sigmf(sl,[1,0]);
                sum =  (ans(i,1) - ol ) * fl * (1-fl) * prev_wkl(kk,1);
                wjk(jj,kk) = wjk(jj,kk) + rate*  sum *  f * (1-f) * oj(jj);
            end
        end
        
        % update wij
        sum=0;        
        for ii = 1:3
            for jj = 1:num_j
                fj = sigmf(sj(jj),[1,0]);
                for kk=1:num_k
                    fk=sigmf(sk(kk),[1 0]);
                    sum = sum + (ans(i,1) - ol)*fk*(1-fk)*wjk(jj,kk);
                end
                wij(ii,jj) = wij(ii,jj) + rate*  sum *  fj * (1-fj) * oi(i,ii);
            end
        end
        error = error + (ans(i) - ol).^2/2;
    end
    e(iter) = error/train_total;
    
    if error < C
        break;
    end
    acc=0;
    for t=1:test_total
        sj = test(t,:)*wij;
        oj = [sj 1];
        
        sk = oj*wjk;
        ok= [sk 1];
        
        sl = ok*wkl;
        ol = round(sigmf(sl,[1,0]));
        if ol== test_ans(t)
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


for ix=-16:16 
    for iy=-16:16
        dx=0.5*(ix-1); 
        dy=0.5*(iy-1);
        oi=[dx dy 1];
        
        sj = oi*wij;
        oj = [sj 1];        
        sk = oj*wjk;
        ok= [sk 1];
        sl = ok*wkl;
        ol = round(sigmf(sl,[1,0]));

        if ol==1
            figure(3);
            axis([-8 8 -8 8]);
            plot(dx,dy, 'g .',x1,y1,'ko',x2,y2,'b+');
            hold on;
        elseif ol==0
            figure(3);
            axis([-8 8 -8 8]);
            plot(dx,dy, 'r .',x1,y1,'ko',x2,y2,'b+');
            hold on;
        end        
    end
end
 