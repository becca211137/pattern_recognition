# Lab2(a) - Multilayer Perceptron with data in lab1
###### tags:`Pattern Recognition`
-    In multilayer perceptron model, use gradient descent method to solve the following problems
-    **Can not use toolbox**, implement the MLP by ourself
### Questions and report

#### Q1 : Two spiral problem:
Design a network to classify 194 patterns into their corresponding two classes. That is, the number of hidden layers and hidden nodes is designed by you.


![](https://i.imgur.com/wACKc3m.png)

![](https://i.imgur.com/J6ZDN2p.png)

**Method:**
這題我使用了兩層 hidden layer ,第一層 20 個 node,第二層 10 個 node,最一開始處理資料時,我先將x y 存到 oi(加上常數 1),並且將資料順序 random,讓同種類的點分散,開始 train 之後,便是接受input,其中採用的 active function 是 sigmoid function,經過跟 weight 內積之後,output 的輸出是 1 或 0(因為只有要分兩類),然後調整 weight,一個 iteration 之後計算 error,直到我指定的最大次數或是 e 小於指定的數字。
**Flow Chart:**
![](https://i.imgur.com/XpLFxOf.png)

**Result:**
![](https://i.imgur.com/PQoGrY6.png)

**Discussion :**
How to determine the hidden node number in each problem?
-    這題花了蠻久的時間,一開始我只有用一層 layer,50 個 node,發現效果蠻差的,所以多設計一層,以及把 iteration 的次數也加高到 10000,但效果還是不好。

Any experiment
-    我只用了八成的資料 training,剩下的兩成用於 test,再每次 iteration 之後都算一次答案的正確性。

**Accuracy :**
![](https://i.imgur.com/OVulceO.png)

#### Q2 : Double-moon problem:
Use the following scripts to generate data
``` matlab=
N=250;
theta1 = linspace(-180,180, N)*pi/360;
r = 8
x1 = -5 + r*sin(theta1)+randn(1,N);
y1 = r*cos(theta1)+randn(1,N);
x2 = 5 + r*sin(theta1)+randn(1,N);
y2 = -r*cos(theta1)+randn(1,N);
figure;
hold on;
axis equal;
plot(x1,y1,'bo');
plot(x2,y2,'rs');
```
Blue points are for class 1, and red points belong to class 2.
Design a network to classify above 500 patterns into their corresponding two classes
![](https://i.imgur.com/MuN7i5Q.png)

**Method:**
這題我使用了一層 hidden layer、四個 node,最一開始處理資料時,我先將 x y 存到 oi(加上常數 1),並且將資料順序 random,讓同種類的點分散,開始 train 之後,便是接受 input,其中採用的 active function 是sigmoid function,經過跟 weight 內積之後,output 的輸出是 1 或 0(因為只有要分兩類),然後調整weight,一個 iteration 之後計算 error,直到我指定的最大次數或是 e 小於指定的數字。
**Flowchart:**
![](https://i.imgur.com/xPq59o4.png)
**Result:**
![](https://i.imgur.com/5K9bcA7.png)
**Discussion :**
How to determine the hidden node number in each problem?
-    因為這題的分布看起來沒有很複雜,所以我決定用一層 layer 就好,然後一開始選擇了三個 node,發現結果蠻普通的,所以改用四個 node。

Any experiment
-    我只用了八成的資料 training,剩下的兩成用於 test,再每次 iteration 之後都算一次答案的正確性,發現結果達到了大於九成的準確率。
-    一開始我的 weight 都是用 random 決定,後來發現這樣有可能會產生很極端的結果,所以我就挑了一次最好的結果,並改用那次初始的 weight。

**Accracy :**
![](https://i.imgur.com/SCdvQQN.png)

#### Q3 : Given 4 classes with Gaussian distribution:
![](https://i.imgur.com/hvif3Li.png)
各產生 150 點， use multilayer perceptron to find the decision
regions。

(b) 將 activation function 改為 ReLu function, 先寫出 wkj, wji完整的 learning rule。再跑程式，收斂有何不一樣?
(c) 利用 MATLAB 的 neural networks 的 toolbox，並做比較。

##### (a) activation function 用 sigmoidal function
**Method :**
這題我使用了一層 hidden layer、五個 node,最一開始處理資料時,我先將 x y 存到 oi(加上常數 1),並且將資料順序 random,讓同種類的點分散,開始 train 之後,便是接受 input,其中採用的 active function 是sigmoid function,經過跟 weight 內積之後,output 的輸出是四個數值,哪一個數值為 1 就是哪一類(其他數值為 0),然後調整 weight,一個 iteration 之後計算 error,直到我指定的最大次數或是 e 小於指定的數字。
![](https://i.imgur.com/hWXKcaB.png)
**Discussion :**
How to determine the hidden node number in each problem?
-    因為這題的分布看起來沒有很複雜,所以我決定用一層 layer 就好,然後一開始選擇了三個 node,發現結果蠻普通的,所以改用五個 node。

Any experiment
-    我只用了八成的資料 training,剩下的兩成用於 test,再每次 iteration 之後都算一次答案的正確性。

**Result :**
![](https://i.imgur.com/W6MpkhT.png)

**Accuracy :**
![](https://i.imgur.com/NLpGCpP.png)

##### (b) 將 activation function 改為 ReLu function
將 active function 改成 ReLu 之後,我試過很多其他微調(像是 rate 之類),發現效果都很差,可能這題並沒有很適合 ReLu funcion 當作 active function。
**Result:**
![](https://i.imgur.com/nK5ZhaX.png)

##### (c) 利用 MATLAB 的 neural networks 的 toolbox:
比較:用函式很快就跑出結果了,但是 perfoemance 和 gradient 都沒有表現的很好,我也試了其他 train function,發現用其他的效果會比 gradient decent 好很多,像試 trainscg 之類的
![](https://i.imgur.com/JoYoZHw.png)
