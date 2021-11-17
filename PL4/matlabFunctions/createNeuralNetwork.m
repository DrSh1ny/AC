%-----------Network 1 Layer Linear--------------
% net = network(1,1,[1],[1],[0],[1]);
% 
% net.layers{1}.transferFcn = 'purelin';
% net.layers{1}.size = 10;
%     
% net.trainFcn = 'traingda';
% net.performFcn = 'mse'; % criterion
% net.trainParam.lr = 0.01; % learning rate
% net.trainParam.epochs = 200; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 80/100;
% net.divideParam.valRatio   = 10/100;
% net.divideParam.testRatio  = 10/100;
% 
% load 'dataset.mat'
% [numRows,nAmostras] = size(totalX);
% t = zeros(10,nAmostras);
% for i=1:nAmostras
%     if(totalY(i)==0)
%         t(10,i)=1;
%     else
%         t(totalY(i),i)=1;
%     end
% end
% 
% rng(23423);
% net=train(net,totalX,t);
% disp(testNeuralNetwork(net,testX,testY));
% save  None_1_Linear net;




%-----------Network 1 Layer Sigmoid--------------
% net = network(1,1,[1],[1],[0],[1]);
% 
% net.layers{1}.transferFcn = 'logsig';
% net.layers{1}.size = 10;
%     
% net.trainFcn = 'traingda';
% net.performFcn = 'mse'; % criterion
% net.trainParam.lr = 0.01; % learning rate
% net.trainParam.epochs = 200; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 80/100;
% net.divideParam.valRatio   = 10/100;
% net.divideParam.testRatio  = 10/100;
% 
% load 'dataset.mat'
% [numRows,nAmostras] = size(totalX);
% t = zeros(10,nAmostras);
% for i=1:nAmostras
%     if(totalY(i)==0)
%         t(10,i)=1;
%     else
%         t(totalY(i),i)=1;
%     end
% end
% 
% rng(23424);
% net=train(net,totalX,t);
% disp(testNeuralNetwork(net,testX,testY));
% save  None_1_Sigmoidal  net;


%-----------Network 1 Layer Hard Limit--------------
% net = perceptron;
% net.trainParam.lr = 0.01; % learning rate
% net.trainParam.epochs = 200; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 80/100;
% net.divideParam.valRatio   = 10/100;
% net.divideParam.testRatio  = 10/100;
%     
% load 'dataset.mat'
% [numRows,nAmostras] = size(totalX);
% t = zeros(10,nAmostras);
% for i=1:nAmostras
%     if(totalY(i)==0)
%         t(10,i)=1;
%     else
%         t(totalY(i),i)=1;
%     end
% end
% 
% rng(567);
% net=train(net,totalX,t);
% disp(testNeuralNetwork(net,testX,testY));
% save  'None_1_Hard Limit' net;


%-----------Network 2 Layer Linear--------------
% load 'dataset.mat'
% [numRows,nAmostras] = size(totalX);
% t = zeros(10,nAmostras);
%  for i=1:nAmostras
%      if(totalY(i)==0)
%          t(10,i)=1;
%      else
%          t(totalY(i),i)=1;
%      end
%  end
% 
% net = feedforwardnet(20);
% net.layers{1}.transferFcn = 'purelin';
% net.layers{2}.transferFcn = 'purelin';
% net.trainFcn = 'traingd';
% net.trainParam.lr = 0.0325; % learning rate;
% net.trainParam.epochs = 1000; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio   = 15/100;
% net.divideParam.testRatio  = 15/100;
% 
% rng(1);
% [net,tr] = train(net,totalX,t);
% accur=testNeuralNetwork(net,testX,testY);
% disp(accur);
% save  None_2_Linear net;

%-----------Network 2 Layer Sigmoid--------------

% load 'dataset.mat'
% [numRows,nAmostras] = size(totalX);
% t = zeros(10,nAmostras);
%  for i=1:nAmostras
%      if(totalY(i)==0)
%          t(10,i)=1;
%      else
%          t(totalY(i),i)=1;
%      end
%  end
% 
% net = feedforwardnet(20);
% net.layers{1}.transferFcn = 'tansig';
% net.layers{2}.transferFcn = 'tansig';
% net.trainFcn='traingd';
% net.trainParam.lr = 1; % learning rate;
% net.trainParam.epochs = 1000; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio   = 15/100;
% net.divideParam.testRatio  = 15/100;
% 
% rng(1);
% [net,tr] = train(net,totalX,t);
% accur=testNeuralNetwork(net,testX,testY);
% disp(accur);
% save  None_2_Sigmoidal net;




%-----------Filter 1 Layer Hard Limit--------------
% net = perceptron;
% net.trainParam.lr = 0.01; % learning rate
% net.trainParam.epochs = 50; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 80/100;
% net.divideParam.valRatio   = 10/100;
% net.divideParam.testRatio  = 10/100;
%     
% load 'dataset.mat'
% [numRows,nAmostras] = size(totalX);
% t = repmat(Perfect,1,100);
% 
% 
% rng(567);
% net=train(net,totalX,t);
% %disp(testNeuralNetwork(net,testX,testY));
% save  'Binary Perceptron_1_Hard Limit' net;

%-----------Filter + Classifier Layer--------------
load 'dataset.mat'
load 'Perfect.mat'
[numRows,nAmostras] = size(totalX);

%Associative Memory
inv = pinv(totalX);
T = repmat(Perfect,1, 100);
Wp = T * inv;

P2 = Wp * totalX;

%Binary Perceptron
net = perceptron;
net.trainParam.lr = 0.01; % learning rate
net.trainParam.epochs = 50; % maximum epochs
net.divideFcn='dividerand';
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio   = 10/100;
net.divideParam.testRatio  = 10/100;
    
load 'dataset.mat'
[numRows,nAmostras] = size(totalX);
t = repmat(Perfect,1,100);


rng(567);
net=train(net,totalX,t);
P3=sim(net,totalX);

net = network(1,1,[1],[1],[0],[1]);

net.layers{1}.transferFcn = 'logsig';
net.layers{1}.size = 10;
    
net.trainFcn = 'traingda';
net.performFcn = 'mse'; % criterion
net.trainParam.lr = 0.01; % learning rate
net.trainParam.epochs = 200; % maximum epochs
net.divideFcn='dividerand';
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio   = 10/100;
net.divideParam.testRatio  = 10/100;

load 'dataset.mat'
[numRows,nAmostras] = size(P2);
t = zeros(10,nAmostras);
for i=1:nAmostras
    if(totalY(i)==0)
        t(10,i)=1;
    else
        t(totalY(i),i)=1;
    end
end

rng(2342);
net=train(net,totalX,t);

%Teste com filtro
disp(testNeuralNetwork(net,P2,totalY));
%Teste com Perceptron
disp(testNeuralNetwork(net,P3,totalY));
%Teste sem filtro
disp(testNeuralNetwork(net,totalX,totalY));
