function [q] = neural_network(P, nnType, transferFunction, trainingFunction, criterion)
%NEURAL_NETWORK Summary of this function goes here

if (nnType == 1)
    net = network(1,1,[1],[1],[0],[1]);
    
    net.layers{1}.transferFcn = transferFunction;
    net.layers{1}.size = 10;
elseif (nnType == 2)
  
    net = network(1,2,[1;1],[1;0],[0 0;1 0],[0 1]);
    net.layers{1}.size=20;
    
    net.layers{1}.transferFcn = transferFunction;
    net.layers{2}.transferFcn = transferFunction;
    
     
net.trainFcn = trainingFunction;
net.performFcn = criterion; % criterion

net.performParam.lr = 0.5; % learning rate
net.trainParam.epochs = 1000; % maximum epochs
net.trainParam.show = 40; % show
net.trainParam.goal = 1e-6; % goal=objective

nAmostras = size(P);
nAmostras = nAmostras(2);
t = eye(10);
t = repmat(t,1,nAmostras/10);

net=train(net,P,t);

q=sim(net,P);

end

