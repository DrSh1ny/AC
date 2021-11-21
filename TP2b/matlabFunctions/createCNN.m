pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadImages(pacients(1),0.8);
[trainX1,trainY1,testX1,testY1]=loadImages(pacients(2),0.8);
trainX=cat(4,trainX,trainX1);
testX=cat(4,testX,testX1);
trainY=cat(1,trainY,trainY1);
testY=cat(1,testY,testY1);

inputSize = [29 29 1];
numClasses = 3;

layers = [
 imageInputLayer(inputSize)
 convolution2dLayer(5,20)
 batchNormalizationLayer
 reluLayer
 fullyConnectedLayer(numClasses)
 softmaxLayer
 classificationLayer];

options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
net = trainNetwork(trainX,trainY,layers,options);

predY = predict(net,testX,'ExecutionEnvironment','cpu')';
[M, predY]=max(predY);
[accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),1);
X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
disp(X);
