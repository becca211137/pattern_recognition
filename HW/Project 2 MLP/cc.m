clear;
% set data1
mu = [0;0];
sigma = [1 0; 0 1];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
temp = zeros(150,1)+1;
oi = [r,temp];
% set data2
mu = [14;0];
sigma = [1 0; 0 4];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
oi = [ oi ;r temp];
% set data3
mu = [7;14];
sigma = [4 0; 0 1];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
oi = [ oi ;r temp];
% set data4
mu = [7;7];
sigma = [1 0; 0 1];
rng default  % For reproducibility
r = mvnrnd(mu,sigma,150);
oi = [ oi ;r temp];
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
% final_ans = zeros(600,4);
% for i=1:600
%     final_ans(i,ans(i)) = 1;
% end
test=oi([train_total+1 :total], :);
% test_ans = final_ans([train_total+1 :total],:);
test_ans  = ans([train_total+1 :total]);
% set initial value

wij = rand(3,5).*2-1;
wjk = rand(6,1).*2-1; 
% wij = [-0.852010460846124,0.965670402787902,-0.691260389041455,0.516224862654837,0.371071417495074;0.368192133924018,-0.195632029555031,-0.237309591111056,0.742222243830778,-0.411702732464301;-0.195223334607676,0.241343894399157,-0.677732056301278,-0.298446510228215,0.0612586077137711];
% wjk = [0.664846772570368,-0.280787364055529,-0.951131967899252,-0.0842273322912663;0.194980383745159,0.116638399738594,-0.419629469738546,-0.519043206335831;-0.329377338589508,0.485090731403878,-0.364958834201547,0.527795888572957;-0.401549953333787,-0.151330432748619,0.307380267932950,0.518654766262193;-0.0948149168613519,-0.141288422847590,0.913871848141368,0.481296129957229;-0.154708693559075,-0.750254482560374,0.871461745569761,0.487376682974652];
i_wij=wij;
i_wjk=wjk;

rate = 0.0001;
C  = 0.005;
max_iter = 500;
iter = 1;
sj = [];
sk = [];
oj = zeros(600,6);
ok = [];
% last result
accuracy=[];
e=[];
% regulize
oi(:,1) = (oi(:,1)-mean(oi(:,1)) ) / std(oi(:,1));
oi(:,2) = (oi(:,2)-mean(oi(:,2)) ) / std(oi(:,2));
while iter<=max_iter 
    error = 0;
    for i = 1:1:train_total
        % foward
        sj = oi(i,:)*wij;
        oj = [sigmf(sj,[1,0]) 1];
        sk = oj*wjk;
        ok= floor(sigmf(sk,[1,0])/0.25);
        prev_wjk = wjk;
        % update w2 
        
            f = sigmf(sk,[1,0]);
            for j=1:6
                wjk(j) =  wjk(j) + rate * (ans(i)-ok)* f * (1-f) * oj(j);
            end
       
        % update w1
        for ii = 1:3
            for jj = 1:5
                f = sigmf(sj(jj),[1,0]);
                sum=0;
                
                fk = sigmf(sk,[1,0]);
                sum = sum + (ans(i) - ok ) * fk * (1-fk) * prev_wjk(jj);

                wij(ii,jj) = wij(ii,jj) + rate*  sum * f * (1-f) * oi(i,ii);
            end
        end
        for tt=1:4    
            error = error + (ans(i) - ok).^2/8;
        end
        
    end
    e(iter) = error/train_total;
    
%     if error < C
%         break;
%     end
    acc=0;
    for t=1:test_total
        sj = test(t,:)*wij;
        oj = [sigmf(sj,[1,0]) 1];
        sk = oj*wjk;
        ok= floor(sigmf(sk,[1,0])/0.25);
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



for ix=-40:40 %% ±q-15~15
    for iy=-40:40
        dx=0.5*(ix-1); 
        dy=0.5*(iy-1);
        oi=[dx dy 1];
%         dx = oi(:,1);
%         dy = oi(:,2);
        sj = oi*wij;
        oj = sigmf(sj,[1,0]);     
        oj = [oj 1];
        sk = oj*wjk;
        ok= round(sigmf(sk,[1,0]));
        figure(3);
        if ok==1
            axis([-20 20 -20 20]);
            plot(dx,dy, 'g .');
            hold on;
        end
        if ok==2
            axis([-20 20 -20 20]);
            plot(dx,dy, 'r .');
            hold on;
         end
         if ok==3
            axis([-20 20 -20 20]);
            plot(dx,dy, 'b .');
            hold on;
         end
        if ok==4
            axis([-20 20 -20 20]);
            plot(dx,dy, 'y .');
            hold on;
        end
        
    end
end
% 
% %%% relu
% wij = rand(3,5)*2-1;
% wjk = rand(6,4)*2-1; 
% i_wij=wij;
% i_wjk=wjk;
% rate = 0.0001;
% iter=1;
% temp2=[];
% while iter<=max_iter 
%     error = 0;
%     for i = 1:1:train_total
%         % foward
%         sj = oi(i,:)*wij;
%         oj = [max(sj,0) 1];
%         sk = oj*wjk;
%         temp2(i,:) = sk;
%         ok= max(sk,0) > 0;
%         prev_wjk = wjk;
%         % update w2 
%         for k=1:4
%             f=1;
%                 if max(sj(k),0)==0
%                     f=0;
%                 end
%             for j=1:6
%                 wjk(j,k) =  wjk(j,k) + rate * (final_ans(i,k)-ok(k))* f * (1-f) * oj(j);
%             end
%         end
%         % update w1
%         for ii = 1:3
%             for jj = 1:5
%                 f=1;
%                 if max(sj(jj),0)==0
%                     f=0;
%                 end
%                 sum=0;
%                 for kk=1:4
%                     fk=1;
%                     if max(sk(kk),0)==0
%                         fk=0;
%                     end
%                     sum = sum + (final_ans(i,k) - ok(k) ) * fk  * prev_wjk(jj,kk);
%                 end
%                 wij(ii,jj) = wij(ii,jj) + rate*  sum  * f  * oi(i,ii);
%             end
%         end
%         for tt=1:4    
%             error = error + (final_ans(i,tt) - ok(tt)).^2/8;
%         end
%         
%     end
%     e(iter) = error/train_total;
%     
% %     if error < C
% %         break;
% %     end
%     acc=0;
%     for t=1:test_total
%         sj = test(t,:)*wij;
%         oj = [max(sj,0) 1];
%         sk = oj*wjk;
%         ok= max(sk,0)>0;
%         prev_wjk = wjk;
%         for temp=1:4
%             if ok(temp) == test_ans(t,temp)
%                 acc = acc+1;
%             end
%         end
%     end
%     acc = acc/test_total/4;
%     accuracy(iter) = acc;
%     iter = iter + 1;
% end
% figure(3);
% plot(e);
% figure(4);
% plot(accuracy);
% 
