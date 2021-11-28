pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadImages(pacients(1),0.8);

inputSize = [29 29 1];
numClasses = 3;

%7 
layers1 = [
 imageInputLayer(inputSize)
 convolution2dLayer(5,20)
 batchNormalizationLayer
 reluLayer
 fullyConnectedLayer(numClasses)
 softmaxLayer
 classificationLayer];

layers2 = [
 imageInputLayer(inputSize)
 convolution2dLayer(3,28)
 maxPooling2dLayer(2)
 convolution2dLayer(3,13)
 batchNormalizationLayer
 reluLayer
 fullyConnectedLayer(numClasses)
 softmaxLayer
 classificationLayer];

layers3 = [
 imageInputLayer(inputSize)
 convolution2dLayer(3,29)
 maxPooling2dLayer(3)
 convolution2dLayer(3,10)
 batchNormalizationLayer
 reluLayer
 fullyConnectedLayer(numClasses)
 softmaxLayer
 classificationLayer];


for layers= {[layers1], [layers2], [layers3]}
    disp(layers{1,1});
    options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
    rng(1);
    net = trainNetwork(trainX,trainY,layers{1,1},options);

    predY = predict(net,testX,'ExecutionEnvironment','cpu')';
    [M, predY]=max(predY);
    [accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),0);
    X = sprintf('0 Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
    disp(X);
    
    [accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),1);
    X = sprintf('1 Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
    disp(X);
end
