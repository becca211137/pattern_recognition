# Lab2(b) - Multilayer Perceptron with MNIST
###### tags:`Pattern Recognition`
- In multilayer perceptron model, use gradient descent method to solve the real data problem in MNIST(http://yann.lecun.com/exdb/mnist/)
- Can not use toolbox, implement the MLP by ourself
- The MNIST database of handwritten digits has a training set of 60,000 examples, and a test set of 10,000 examples.

## Questions
- In multilayer perceptron model, use gradient descent method to solve the real data problem in MNIST. Do not use toolbox.
- The MNIST database of handwritten digits has a training set of 60,000 examples, and a test set of 10,000 examples

## Method
這題我使用了一層 hidden layer ，250 個 node，開始 train 之後，便是接受 input，其中採用的 active function 是 sigmoid function(或者 reLu)，經過跟 weight 內積之後，output 的輸出跟正確答案比較後調整
weight，直到我指定的最大次數。
![image](https://user-images.githubusercontent.com/22147510/150740387-d0c1a04c-87c1-41e5-b22d-42dee3c99761.png)

### Q1: Use 1000 examples for training, 1000 for testing
#### A. Use sigmoidal function as activation function
(1)Plot the figure of average error vs. iteration, CPU time in learning. 
(2)輸出前 100 個訓練的圖形，放成 10x10 的 排列。
(3)輸出前 100 個測試的圖形，放成 10x10 的 排列，每一個圖形的下面要標示 desired class, 最後辨認的 output class，對或錯。
![image](https://user-images.githubusercontent.com/22147510/150740652-f6d13286-718c-4ee0-9692-1a9b0ec4e661.png)
(4)confusion matrix (%)
![image](https://user-images.githubusercontent.com/22147510/150740721-f7918b8f-b543-4a16-bae4-73669e8f7d47.png)

**Discussion**

How to determine the hidden node number ?
- 我使用了一層 hidden layer , 250 個 nodes, 會這樣使用是因為我之前用了兩層以上的 layer，發現效率很慢，而且準確率不高，似乎有 overfitting 的現象，後來發現這樣使用準確率還不錯，而且蠻快的。
**Describe any phenomenon you watched**
- 試過許多不同的 node 數量，發現 200-400 個 node 做出來的準確率試差不多的。

#### B. Use Relu function as activation function 
(1)Plot the figure of average error vs. iteration, CPU time in learning. 
(2)輸出前 100 個訓練的圖形，放成 10x10 的 排列。
(3)輸出前 100 個測試的圖形，放成 10x10 的 排列，每一個圖形的下面要標示 desired class, 最後辨認的 output class，對或錯。
![image](https://user-images.githubusercontent.com/22147510/150741128-a43e787a-a18f-4c4e-879d-2f11b46e8656.png)

(4)confusion matrix (%)
![image](https://user-images.githubusercontent.com/22147510/150741200-330a2c3e-520e-4fa1-a20b-1e925fb46f20.png)

**Discussion**

How to determine the hidden node number ? 
- 因為是跟 sigmoid 的比較，所以就跟之前用的一樣。

**Describe any phenomenon you watched**
- 試過許多不同的 node 數量或改一些 rate 的參數，發現結果都很差，如果要用 relu 應該要重新整個設計過，才能達到高的準確率。

**與 sigmoid 的收斂有什麼不一樣?** 
- 很快就達到收斂，但是效果很差。

#### C. Use Matlab toolbox, and comopare
(1)Plot the figure of average error vs. iteration, CPU time in learning. 
(2)輸出前 100 個訓練的圖形，放成 10x10 的 排列。
(3)輸出前 100 個測試的圖形，放成 10x10 的 排列，每一個圖形的下面要標示 desired class, 最後辨認的 output class，對或錯。
![image](https://user-images.githubusercontent.com/22147510/150743039-9c085de8-c1d8-484b-8e14-5cf831185cb4.png)

(4) confusion matrix 

![image](https://user-images.githubusercontent.com/22147510/150743090-d049e485-1312-41b6-bfcf-05b5cb794e88.png)

**Discussion**

How to determine the hidden node number ? 
- 因為是跟之前的比較，所以就跟之前用的一樣。

**Describe any phenomenon you watched**
- 試過許多不同的 node 數量，發現 200-400 個 node 做出來的準確率試差不多的。

**與不用 toolbox 有什麼不一樣?**
- 除了只要把 input 跟環境設好非常方便外，toolbox 的效率很高，準確率也還不錯。

### Q2: Use 60000 examples for training, 10000 for testing

#### A. Use sigmoidal function as activation function
(1)Plot the figure of average error vs. iteration, CPU time in learning. 
(2)輸出前 100 個訓練的圖形，放成 10x10 的 排列。
(3)輸出前 100 個測試的圖形，放成 10x10 的 排列，每一個圖形的下面要標示 desired class, 最後辨認的 output class，對或錯。

![image](https://user-images.githubusercontent.com/22147510/150743673-d3c4b6ab-04cd-4530-9751-80c11b9e4f7a.png)
![image](https://user-images.githubusercontent.com/22147510/150743721-9b58d97e-3370-4b9d-9939-1defda9178ae.png)

(4)confusion matrix (%)
![image](https://user-images.githubusercontent.com/22147510/150743758-3b2bd350-3a59-497a-b6bb-4d5a7ee08ba0.png)

**Discussion**
- 除了資料的比數以外都和實驗一一樣，而準確率在實驗一中雖然已經很高了，但 train 的比數拉大，準確率還是上升了。

#### B. Use Relu function as activation function 
(1)Plot the figure of average error vs. iteration, CPU time in learning. 
(2)輸出前 100 個訓練的圖形，放成 10x10 的 排列。
(3)輸出前 100 個測試的圖形，放成 10x10 的 排列，每一個圖形的下面要標示 desired class, 最後辨認的 output class，對或錯。
![image](https://user-images.githubusercontent.com/22147510/150743892-f91f4911-3cba-436e-8b7f-03c927326a13.png)
![image](https://user-images.githubusercontent.com/22147510/150743922-e89e1e4d-e57e-49e4-9be9-a2e89319a4c7.png)

(4)confusion matrix (%)
![image](https://user-images.githubusercontent.com/22147510/150743963-bd5198d4-b043-4dfb-94a2-a30cba314011.png)

#### C. Use Matlab toolbox, and comopare
(1)Plot the figure of average error vs. iteration, CPU time in learning. 
(2)輸出前 100 個訓練的圖形，放成 10x10 的 排列。
(3)輸出前 100 個測試的圖形，放成 10x10 的 排列，每一個圖形的下面要標示 desired class, 最後辨認的 output class，對或錯。
![image](https://user-images.githubusercontent.com/22147510/150744056-a827ef9a-9f68-4af8-9638-6fac9892b568.png)
![image](https://user-images.githubusercontent.com/22147510/150744100-b9f6d2d8-b14c-41d6-8f1a-058954e48500.png)

(4)confusion matrix (%)

![image](https://user-images.githubusercontent.com/22147510/150744147-79e73dfe-0161-4a29-8d11-c4953cc5eb64.png)

**Discussion**
- 基本上除了 train 的時間稍微拉長一點以外，還有準確率稍微上升，沒有什麼差太多的地方
