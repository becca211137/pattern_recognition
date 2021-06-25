clear;
clc;
net = feedforwardnet(3);
% net.input{1}.size = 1;
net.layers{2}.size = 4;

% net.layers{3}.size = 4;

net.view