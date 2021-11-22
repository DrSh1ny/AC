pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
trainX = normalize(trainX,'range');
testX = normalize(testX,'range');

trainY=categorical(trainY)';
testY=categorical(testY)';
trainX=num2cell(trainX,1);
testX=num2cell(testX,1);

numFeatures = 29;
numHiddenUnits = 30;
numClasses = 3;
layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
rng(1);
net = trainNetwork(trainX,trainY,layers,options);

predY = predict(net,testX,'ExecutionEnvironment','cpu')';
[M, predY]=max(predY);
[accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),1);
X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
disp(X);

