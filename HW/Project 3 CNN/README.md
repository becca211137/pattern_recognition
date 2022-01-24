# Lab3 - CNN Using Matlab Toolbox
###### tags:`Pattern Recognition`
Use Neural Network Toolbox (Convolutional neural network) in Matlab to create CNN classification model

## Question and Report
### Q1 : 
Given f(i ∆t) = 0.1, i=1, …, 4, and g(i ∆t) = 0.1, i=1, …, 4, ∆t = 0.1 second, find 1D convolutional result of f and g.
Sequence of samples of f = {0.1, 0.1, 0.1, 0.1} ∆t=0.1 seconds.
Sequence of samples of g = {0.1, 0.1, 0.1, 0.1} ∆t=0.1 seconds.
(Use toolbox and Self-programming)

**Result**

![image](https://user-images.githubusercontent.com/22147510/150752543-bfe65cc1-f804-43e3-aef9-d8602a288e5c.png)

### Q2 :
Given f(i ∆x, j∆y) = 0.1, i=1, …, 4, j=1, …, 4, and g(i ∆x, j∆y) = 0.1, i=1, …, 4,
j=1, …, 4, ∆x=0.1, ∆y=0.1 find 2D convolutional result of f and g.
(Use toolbox and Self-programming)

**Result**

![image](https://user-images.githubusercontent.com/22147510/150752680-b0df4d2c-3d2c-4e60-ad51-7a098db59bbe.png)

### Q3 : Use Matlab Convolutional neural network (CNN) toolbox to deal with MNIST Image Dataset
#### A. Use 1000 examples for training, 1000 for testing
##### Method
Set initial value(ex: test number) → load image(用助教給的) → design model → set option → train → show result
##### Plot the average error vs. iteration, CPU time in learning.
![image](https://user-images.githubusercontent.com/22147510/150753190-199b5450-f77e-41c3-bdf7-09d0de3de43b.png)
##### 輸出各層抽取的特徵圖。
![image](https://user-images.githubusercontent.com/22147510/150753251-ee181db9-11a6-4f48-b6bd-2d9a29c0c676.png)
##### 輸出 150 個測試的圖形
![image](https://user-images.githubusercontent.com/22147510/150753286-890a3769-aee4-4a83-b265-1ec8ae4602d0.png)
##### confusion matrix
![image](https://user-images.githubusercontent.com/22147510/150753344-82e7c2f5-d617-46b4-baf0-49e220b8de0f.png)


#### B. Use 60000 examples for training, 10000 for testing。

##### Method
Set initial value(ex: test number) → load image(用助教給的) → design model → set option → train → show result
##### Plot the average error vs. iteration, CPU time in learning.
![image](https://user-images.githubusercontent.com/22147510/150753420-2c1eec41-f560-44f1-8179-4aad68b92783.png)

##### 輸出各層抽取的特徵圖。
![image](https://user-images.githubusercontent.com/22147510/150753251-ee181db9-11a6-4f48-b6bd-2d9a29c0c676.png)

##### 輸出 150 個測試的圖形
![image](https://user-images.githubusercontent.com/22147510/150753517-46f9d2d1-0ead-4bc9-8c84-1c64b93638fa.png)
##### confusion matrix
![image](https://user-images.githubusercontent.com/22147510/150753564-2a223cec-901b-419d-bd59-98291e08c458.png)

##### Discussion:
跟上次的作業比起來這次的準確定比較高，加上用 toolbox 比較，train 的時間少了很多，覺得熟悉toolbox 的話會是很強大方便的工具
