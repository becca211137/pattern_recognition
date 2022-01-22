# Lab1 - Plot data 
###### tags:`Pattern Recognition`
In this Lab we need to 
-    Use Matlab to draw some mathematical function 
-    Implement popular functions, e.g., Gaussian function 
-    Get familiar with MNIST database

### Question and report

#### Q1 : Given 1-d Gaussian function, draw it. (Mean 與 variance 自訂)(例如: Mean (μ) = 3, variance ($σ^2$) = 4, μ-3σ ≤ x-coordinate range ≤ μ+3σ.)
``` matlab=
x = -2:0.1:8; 
y = gaussmf(x,[2 4]);
figure(1);
plot(x,y);
title('1-d Gaussian function');
```
![](https://i.imgur.com/w1jNCPG.png)



#### Q2 : Given 2-d Gaussian function, draw it. (Mean 與 covariance matrix 自訂)(例如: Mean (μ) = [1; 2], covariance matrix (Σ) = [1 0; 0 1], μ-3σ ≤ x-coordinate range ≤ μ+3σ.)
``` matlab=
h = fspecial('gaussian', [30 30], 4);
figure(2);
surf(h);
title(' 2-d Gaussian function');
```
![](https://i.imgur.com/jjRIdZM.png)

#### Q3 : Call 1-d Gaussian random data and plot 1-d histogram.(例如: Mean (μ) = 0, variance ($σ^2$) = 1.)

``` matlab=
rng default; % For reproducibility                        
r = normrnd(0,1,1000,1);
figure(3);
histogram(r);
title(' 1-d Gaussian random data and plot 1-d histogram');
```
![](https://i.imgur.com/Xz8z82B.png)

#### Q4 : Call 2-d Gaussian random data. 點在 2-d space 上。 Plot 2-d histogram.(例如: Mean (μ) = [1; 2], covariance matrix (Σ) = [3 0; 0 4])Hint: 透過 mvnrnd 函數產生 2 維高斯亂數,並使用 plot 函數點出 2-d 高斯亂數,最後使用 hist3 函數畫出 2-d histogram。
``` matlab=
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
```
![](https://i.imgur.com/ZLsL4Wt.png)

#### Q5 : 承(4),在 2-d histogram 上畫等高線圖。
``` matlab=
[n,c] = hist3(R, [10 10]); 
contour(c{1}, c{2}, n);
[a,handle] = contour(c{1}, c{2}, n);
clabel(a, handle);
title(' contour for the previous 2-d histogram ');
```
![](https://i.imgur.com/JK7RCJg.png)

#### Q6 : Plot line x-y=1.
``` matlab=
x = linspace(0, 10); 
y = x - 1;
plot(x, y);
title('x-y=1');
```
![](https://i.imgur.com/brdZ1Fv.png)

#### Q7 : Plot circle $x^2+y^2$=1.
``` matlab=
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
```
![](https://i.imgur.com/s4LqQJb.png)


#### Q8 : Plot ellipse $x^2+y^2/4$ =1.
``` matlab=
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
```
![](https://i.imgur.com/6KI9V9l.png)

#### Q9 : Plot hyperbola $x^2-y^2/4$ =1.
``` matlab=
figure(10);
x = [-5:0.1:-1];
x = [x 1:0.1:5];
y1 = sqrt(x.^2-1) * 2;
y2 = - sqrt(x.^2-1) * 2;
plot(x,y1,'b',x,y2,'b');
ezplot('x.^2 - (y.^2)/4 -1'); 
```
![](https://i.imgur.com/HnZSA1u.png)



#### Q10 : Generate data of line 2x-y=0 and plot. (產生 100 點,畫在 2-d 上)
``` matlab=
figure(11);                 
x = (0:1:100);
y = 2*x;
plot(x,y,'.');
title('2x-y=0');
```
![](https://i.imgur.com/j7a1weZ.png)


#### Q11 : Generate data of circle $x^2+y^2$=4 and plot. (產生 100 點,畫在 2-d 上)

``` matlab=
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
```
![](https://i.imgur.com/ul8Deic.png)

#### Q12 : Generate data of ellipse $x^2/4+y^2$=1 and plot. (產生 100 點,畫在 2-d 上)
``` matlab= 
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
```
![](https://i.imgur.com/VCFyEZc.png)

#### Q13 : Generate data of hyperbola xy=1 and plot. (產生 100 點,畫在 2-d 上)
``` matlab= 
figure(14);                                       
x = (-1:0.02:1);
y = 1./x;
plot(x,y,'.');
axis([-1 1 -15 15]);
title('xy =1');

```
![](https://i.imgur.com/guSMerx.png)

#### Q14 : Plot two spirals.![](https://i.imgur.com/gSdhw6Q.png)

``` matlab= 
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
```

![](https://i.imgur.com/PyxBXEx.png)

#### Q15 : Plot 8 points in the three dimensional space, and the plane z = x – y + 0.5 that can separate these two classes.![](https://i.imgur.com/cTzb2ZJ.png)
``` matlab= 
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

```
![](https://i.imgur.com/5wVqjQj.png)


#### Q16 : Plot double moon problem:自己設計程式產生 data,二個 moons 的距離可以拉近或遠離。Blue points are for class 1, and red points belong to class 2.

``` matlab= 
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
```
![](https://i.imgur.com/tKu3CuO.png)

#### Q17 : Given 5 sine function with different periods (different frequencies), 利用動畫顯示這 5 個 sine functions。週期為 T0, T0/2, ..., T0/5. T0 與 function 取樣的點數自訂。動畫顯示的快慢由自己決定或以 10 秒、20 秒、及 30 秒作動畫顯示。

``` matlab= 
figure(18);                       
x = 0:0.1:8*pi;
for i = 1:250
    plot(x, sin(x*floor(i/50)));
    axis([-inf inf -1 1]);
    grid on
    drawnow
end

```
![](https://i.imgur.com/aDOekme.png)


#### Q18 : Design a uniform random number generator. (必須做分析,如何設計?)(a) Given a seed number (SEED) and number of data (RANDX), generaterandom values between 0.0 and 1.0.(b) Extend to the values between a lower bound and an upper bound.

分析:這題我使用了linear congruential generator這個方法，他是目前最被廣泛使用且歷史最悠久的一種算法。基本上只有一個公式: ![](https://i.imgur.com/3vstowR.png)
而雖然我們從公式中可以看到，r的下個值可以被前一個值預測，這個公式還是可以用於簡單的亂數產生(不包括需要高度安全的狀況)，而還有一個重點是 a, c ,m 應該選何值，怎麼選比較好，關於這點也有很多種作法，我選擇其中一個microsoft formula 實作，最大的數會到32767。而如果係數選得好的話，產生的亂數會接近uniform的理想結果。

``` matlab = 
a = 214013; 
seed = 0;
c = 2531011;
m=2147483648;
for i = 1:100
    seed =mod( (a *seed + c) ,m); 
    ans = bitshift(seed, -16);
    disp(ans./32767)
end

```
(a)部分結果-產生0~1的數字
```
0.5098
0.4657
0.4865
0.0838
0.8354
0.8811
0.5495
0.5088
0.0962
0.3607
```
(b)如果要設其他範圍，只要對a的結果處理即可，例如想要產生1~4，就將a的結果乘以三再加1，以此類推

參考:[link](http://edisonx.pixnet.net/blog/post/69653913-%5Brand%5D-linear-congruential-generator-(%E7%B7%9A%E6%80%A7%E5%90%8C%E9%A4%98%E6%B3%95,lcg)
)


#### Q19 : Design a Gaussian (normal) random number generator. (必須做分析,如何設計?)(a) Given a seed number (SEED) and number of data (RANDX), generate random values with mean 0 and standard deviation 1, i.e., N(0, 1).(b) Modify to mean m and standard deviation σ, i.e., N(m, $σ^2$).

![](https://i.imgur.com/gIiEo72.png)


``` matlab= 
u = rand(2,100000);                                     
r = sqrt(-2*log(u(1,:)));
theta = 2*pi*u(2,:);
x = r.*cos(theta);
y = r.*sin(theta);
figure(19);
hist(x,100);
```
![](https://i.imgur.com/PcGZdIB.png)
參考:
[link1](https://theclevermachine.wordpress.com/2012/09/11/sampling-from-the-normal-distribution-using-the-box-muller-transform/)
[link2](https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform)
[link3](https://www.alanzucconi.com/2015/09/16/how-to-sample-from-a-gaussian-distribution/)

#### Q20 : 在 convolutional neural network (CNN) 裡有一個做實驗的 database MNIST.打 keywords: mnist database,或直接到 MNIST 的網頁http://yann.lecun.com/exdb/mnist 讀取 image data。The MNIST database of handwritten digits has a training set of 60,000 patterns, and a test set of 10,000 patterns. 在之後的 project 我們可選取例如 2000 個 patterns 做 training,2000 個 patterns 做 testing。這一 project 先讀取 data,隨意讀取 150 個圖形,輸出成 15x10 的一張圖。
``` matlab= 
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
for tmp = 1:150
    if mod(tmp,15) == 0
        img( (ceil(tmp/15) *28 - 27) : ceil(tmp/15) *28, 393:420) = reshape(image(:,tmp),28,28);
    else
        img( (ceil(tmp/15) *28 - 27) : ceil(tmp/15) *28,  (mod(tmp,15)*28-27) : mod(tmp,15)*28) = reshape(image(:,tmp),28,28);
    end
end
imshow(img);

```
![](https://i.imgur.com/yDGu7fS.png)
