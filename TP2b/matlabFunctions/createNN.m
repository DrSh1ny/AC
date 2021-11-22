pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadDataset(pacients(1),0.8);
targets=zeros(3,size(trainY,2));
for i=1:size(trainY,2)
    targets(trainY(i),i)=1;
end

net = feedforwardnet(20);
net.trainParam.epochs = 100; % maximum epochs
net.divideFcn='dividerand';
net.divideParam.trainRatio = 100/100;
net.divideParam.valRatio   = 0/100;
net.divideParam.testRatio  = 0/100;
rng(1);
[net,tr] = train(net,trainX,targets);

q=sim(net,testX);
q=softmax(q);
[M, predY]=max(q);
[accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
disp(X);

save('../networks/nn','net')

