% 1
% mean = 2, var = 4, £g-3£m ? x-coordinate range ? £g+3£m

x = 0:0.1:10;
y = gaussmf(x,[2 5]);
figure(1);
plot(x,y);
title('1-d Gaussian function');

% 2
% h = fspecial('gaussian',hsize,sigma)
h = fspecial('gaussian', [30 30], 4);
figure(2);
surf(h);
title(' 2-d Gaussian function');

% 3
% R = normrnd(mu,sigma,m,n)
rng default; % For reproducibility
r = normrnd(0,1,1000,1);
figure(3);
histogram(r);
title(' 1-d Gaussian random data and plot 1-d histogram');

% 4
% 
mu = [1 2];
sigma = [3 0; 0 4];
rng default  % For reproducibility
R = mvnrnd(mu,sigma,5000);
figure(4);
plot(R(:,1),R(:,2),'.','MarkerSize',8);
title(' 2-d Gaussian random data');
figure (5);
hist3(R);
title('  2-d histogram for 2-d Gaussian random data');

% 5
figure(6);
 [n,c] = hist3(R, [10 10]);
 contour(c{1}, c{2}, n);
 [a,handle] = contour(c{1}, c{2}, n);
 clabel(a, handle);
title(' contour for the previous 2-d histogram ');

% 6
x = linspace(0, 10);
y = x - 1;
figure(7);
plot(x, y);
title('x-y=1');


% 7
figure(8);
title('x^2 + y^2 =1');
r = 1;
xc = 0;
yc = 0;
theta = linspace(0,2*pi);
x = r*cos(theta) + xc;
y = r*sin(theta) + yc;
plot(x,y);
axis equal;

% 8
a=1; % horizontal radius
b=2; % vertical radius
x0=0; % x0,y0 ellipse centre coordinates
y0=0;
t=linspace(0,2*pi);
x=x0+a*cos(t);
y=y0+b*sin(t);
figure(9);
plot(x,y)
axis([-4 4 -3 3]);
title('x^2 + y^2/4 = 1');

% 9
figure(10);
x = [-5:0.1:-1];
x = [x 1:0.1:5];
y1 = sqrt(x.^2-1) * 2;
y2 = - sqrt(x.^2-1) * 2;
plot(x,y1,'b',x,y2,'b');

% 10
figure(11);
x = (0:1:100);
y = 2*x;
plot(x,y,'.');
title('2x-y=0');

% 11
figure(12);
title('x^2 + y^2 =4');
r = 2;
xc = 0;
yc = 0;
theta = (-5:0.1:5);
x = r*cos(theta) + xc;
y = r*sin(theta) + yc;
plot(x,y,'.');
axis equal;

% 12
a=2; % horizontal radius
b=1; % vertical radius
x0=0; % x0,y0 ellipse centre coordinates
y0=0;
t=(-5:0.1:5);
x=x0+a*cos(t);
y=y0+b*sin(t);
figure(13);
plot(x,y,'.')
axis([-2 2 -2 2]);
title('x^2 + y^2/4 = 1');

% 13
figure(14);
x = (-1:0.02:1);
y = 1./x;
plot(x,y,'.');
axis([-1 1 -15 15]);
title('xy =1');

% 14
 for i = 0 : 1 : 96
     r = 6.5 * (104 - i) / 104;
     theta = pi * i /16 ;
     temp1 = r * sin(theta);
     temp2 = r * cos(theta);
     temp3 = -r * sin(theta);
     temp4 = -r * cos(theta);
     if i == 0
         x1 = [temp1];
         y1 = [temp2];
         x2 = [temp3];
         y2 = [temp4];
     end
     x1 = [ x1 temp1];
     y1 = [ y1 temp2];
     x2 = [ x2 temp3];
     y2 = [ y2 temp4];
     
 end
 figure(15);
 plot(x1,y1,'o',x2,y2,'x');
 title('two spirals');
 
 % 15
 x1 = [0 0 1 0];
 y1 = [1 0 1 1];
 z1 = [1 1 1 0];
 x2 = [0 1 1 1];
 y2 = [0 0 0 1];
 z2 = [0 0 1 0];
 figure(16);
 scatter3(x1,y1,z1,'b');
 hold on;
 scatter3(x2,y2,z2,'r');
 hold on;
 pointA = [1,1,0.5];
pointB = [2.5,0,3];
pointC = [3.5,2,2]; 
 normal = cross(pointA-pointB, pointA-pointC); 
x = [pointA(1) pointB(1) pointC(1)];  
y = [pointA(2) pointB(2) pointC(2)];
z = [pointA(3) pointB(3) pointC(3)];  
A = normal(1); B = normal(2); C = normal(3);
D = -dot(normal,pointA);
zLim = [min(z) max(z)];
yLim = [min(y) max(y)];
[Y,Z] = meshgrid(yLim,zLim);
X = (C * Z + B * Y + D)/ (-A);
reOrder = [1 2  4 3];
patch(X(reOrder),Y(reOrder),Z(reOrder),'r');
grid on;
alpha(0.3);

% 16

moon = 100;
r = randi([1 160],1,80);
x1 = [-10:0.5:10];
x2 = [ 0 : 0.5 : 20];
y1 = sqrt(100 + moon - x1.^2);
y2 = sqrt(150 + moon - x1.^2);
y3 = sqrt(200 + moon - x1.^2);
y4 = sqrt(250 + moon - x1.^2);
temp1 = [y1 y2 y3 y4];
y5 = -sqrt( 100 + moon - (x2 - 10).^2 );
y6 = -sqrt( 150 + moon - (x2 - 10).^2 );
y7 = -sqrt( 200 + moon - (x2 - 10).^2 );
y8 = -sqrt( 250 + moon - (x2 - 10).^2 );
temp2 = [y5 y6 y7 y8];
x1 = [x1 x1 x1 x1];
x2 = [x2 x2 x2 x2];
pic_x1 = x1(r);
pic_y1 = temp1(r);
pic_x2 = x2(r);
pic_y2 = temp2(r);
figure(17);
plot(pic_x1,pic_y1,'o','MarkerEdgeColor','b');
hold on;
plot(pic_x2,pic_y2,'o','MarkerEdgeColor','r');
hold on;

% 17
figure(18);
x = 0:0.1:8*pi;
for i = 1:250
    plot(x, sin(x*floor(i/50)));
    axis([-inf inf -1 1]);
    grid on
    drawnow
end
% 18
a = 214013; 
seed = 0;
c = 2531011;
m=2147483648;
for i = 1:100
    seed =mod( (a *seed + c) ,m); 
    ans = bitshift(seed, -16);
    disp(ans./32767)
end

% 19
% NORMAL SAMPLES USING BOX-MUELLER METHOD

u = rand(2,100000);
r = sqrt(-2*log(u(1,:)));
theta = 2*pi*u(2,:);
x = r.*cos(theta);
y = r.*sin(theta);
figure(19);
hist(x,100);

% 20


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


num = [1:150];
for tmp = 1:150
    if mod(tmp,15) == 0
        img( (ceil(tmp/15) *28 - 27) : ceil(tmp/15) *28, 393:420) = reshape(image(:,tmp),28,28);
    else
        img( (ceil(tmp/15) *28 - 27) : ceil(tmp/15) *28,  (mod(tmp,15)*28-27) : mod(tmp,15)*28) = reshape(image(:,tmp),28,28);
    end
end
imshow(img);








