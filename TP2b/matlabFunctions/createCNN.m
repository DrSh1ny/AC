pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadImages(pacients(2),0.8);
% [trainX1,trainY1,testX1,testY1]=loadImages(pacients(2),0.8);
% trainX=cat(4,trainX,trainX1);
% testX=cat(4,testX,testX1);
% trainY=cat(1,trainY,trainY1);
% testY=cat(1,testY,testY1);

inputSize = [29 29 1];
numClasses = 3;

% layers = [
%  imageInputLayer(inputSize)
%  convolution2dLayer(5,20)
%  batchNormalizationLayer
%  reluLayer
%  fullyConnectedLayer(numClasses)
%  softmaxLayer
%  classificationLayer];

% layers = [
%  imageInputLayer(inputSize)
%  convolution2dLayer(3,28)
%  maxPooling2dLayer(2)
%  convolution2dLayer(3,13)
%  batchNormalizationLayer
%  reluLayer
%  fullyConnectedLayer(numClasses)
%  softmaxLayer
%  classificationLayer];

% layers = [
%  imageInputLayer(inputSize)
%  convolution2dLayer(3,29)
%  maxPooling2dLayer(3)
%  convolution2dLayer(3,10)
%  batchNormalizationLayer
%  reluLayer
%  fullyConnectedLayer(numClasses)
%  softmaxLayer
%  classificationLayer];

for i=1:10
    options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
    rng(i);
    net = trainNetwork(trainX,trainY,layers,options);

    predY = predict(net,testX,'ExecutionEnvironment','cpu')';
    [M, predY]=max(predY);
    [accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),1);
    X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
    disp(X);
end
