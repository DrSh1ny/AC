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
% save  net_1_linear net;




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
% save  net_1_sig  net;


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
% save  net_1_hardlim net;


%-----------Network 2 Layer Linear--------------
% net = network(1,2,[1;1],[1;0],[0,0;1,0],[0,1]);
% 
% net.layers{1}.transferFcn = 'purelin';
% net.layers{2}.transferFcn = 'purelin';
% net.layers{1}.size = 20;
% net.layers{2}.size = 10;
% 
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
% save  net_2_linear net net;


%-----------Network 2 Layer Simoid--------------
% net = network(1,2,[1;1],[1;0],[0,0;1,0],[0,1]);
% 
% net.layers{1}.transferFcn = 'logsig';
% net.layers{2}.transferFcn = 'logsig';
% net.layers{1}.size = 20;
% net.layers{2}.size = 10;
% 
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
% save  net_2_sig net;


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
% save  filter_1_hardlim net;
