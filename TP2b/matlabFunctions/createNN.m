% - Discover
% [trainX,trainY,testX,testY]=loadDataset("../dataset/44202.mat",0.8);
% trainY(find(trainY==3))=1;
% testY(find(testY==3))=1;
% targets=zeros(2,8073);
% for i=1:8073
%     targets(trainY(i),i)=1;
% end
% 
% net = feedforwardnet(20);
% %net.layers{1}.transferFcn = 'tansig';
% %net.layers{2}.transferFcn = 'tansig';
% net.trainParam.epochs = 500; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio   = 0/100;
% net.divideParam.testRatio  = 0/100;
% rng(1);
% [net,tr] = train(net,trainX,targets);
% 
% [accuracy, sensibility, specificity] = Measures(net, testX, testY);
% X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
% disp(X);


% - Predict
[trainX,trainY,testX,testY]=loadDataset("../dataset/63502.mat",0.8);
trainY(find(trainY==3))=2;
testY(find(testY==3))=2;
targets=zeros(2,size(trainY,2));
for i=1:size(trainY, 2)
    targets(trainY(i),i)=1;
end

net = feedforwardnet(20);
%net.layers{1}.transferFcn = 'tansig';
%net.layers{2}.transferFcn = 'tansig';
net.trainParam.epochs = 500; % maximum epochs
net.divideFcn='dividerand';
net.divideParam.trainRatio = 100/100;
net.divideParam.valRatio   = 0/100;
net.divideParam.testRatio  = 0/100;
rng(1);
[net,tr] = train(net,trainX,targets);


[accuracy, sensibility, specificity] = Measures(net, testX, testY);
X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
disp(X);