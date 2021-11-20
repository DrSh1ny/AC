pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadDataset(pacients(1),0.8);
targetsTrain=zeros(3,size(trainY,2));
for i=1:size(trainY,2)
    targetsTrain(trainY(i),i)=1;
end
targetsTest=zeros(3,size(testY,2));
for i=1:size(testY,2)
    targetsTest(testY(i),i)=1;
end

%transformar dataset de matrix para cells
trainX=num2cell(trainX,1);
testX=num2cell(testX,1);
targetsTrain=num2cell(targetsTrain,1);
targetsTest=num2cell(targetsTest,1);


%criar network e treinar
net = narxnet([1:2],[1:2],10);
[Xs,Xi,Ai,Ts] = preparets(net,trainX,{},targetsTrain);
rng(1);
net = train(net,Xs,Ts,Xi,Ai);

%fazer previsao
[shiftedTestX,Xi,Ai,shiftedTestY] = preparets(net,testX,{},targetsTest);
q=sim(net,shiftedTestX);
q=cell2mat(q);
q=softmax(q);
[M, predY]=max(q);
testY=cell2mat(shiftedTestY);
[M, testY]=max(testY);
[accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
disp(X);

save('../networks/dnn','net')
