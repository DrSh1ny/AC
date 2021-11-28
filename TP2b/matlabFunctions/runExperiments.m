%----------------------NN com diferentes layers para os dois pacientes
pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadDataset(pacients(1),0.8);
targets=zeros(3,size(trainY,2));
for i=1:size(trainY,2)
    targets(trainY(i),i)=1;
end

for layers={[20 10],[20],[10]}
    
    disp(layers{1,1});
    net = feedforwardnet(layers{1,1});
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
    [accuracy, sensibility, specificity] = computeMeasures(predY, testY, 1);
    X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
    disp(X);
end

pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
targets=zeros(3,size(trainY,2));
for i=1:size(trainY,2)
    targets(trainY(i),i)=1;
end

for layers={[20 10],[20],[10]}
    disp(layers{1,1});
    net = feedforwardnet(layers{1,1});
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
    [accuracy, sensibility, specificity] = computeMeasures(predY, testY, 1);
    X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
    disp(X);
end

%---------------------------Dynamic NN
% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadDataset(pacients(1),0.8);
% targetsTrain=zeros(3,size(trainY,2));
% for i=1:size(trainY,2)
%     targetsTrain(trainY(i),i)=1;
% end
% targetsTest=zeros(3,size(testY,2));
% for i=1:size(testY,2)
%     targetsTest(testY(i),i)=1;
% end
% 
% %transformar dataset de matrix para cells
% trainX=num2cell(trainX,1);
% testX=num2cell(testX,1);
% targetsTrain=num2cell(targetsTrain,1);
% targetsTest=num2cell(targetsTest,1);
% 
% 
% for layerSize=[10,20,30]
%     %criar network e treinar
%     net = narxnet([1:2],[1:2],layerSize);
%     [Xs,Xi,Ai,Ts] = preparets(net,trainX,{},targetsTrain);
%     rng(1);
%     net = train(net,Xs,Ts,Xi,Ai);
% 
%     %fazer previsao
%     [shiftedTestX,Xi,Ai,shiftedTestY] = preparets(net,testX,{},targetsTest);
%     q=sim(net,shiftedTestX);
%     q=cell2mat(q);
%     q=softmax(q);
%     [M, predY]=max(q);
%     testY=cell2mat(shiftedTestY);
%     [M, testY]=max(testY);
%     [accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
%     X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
%     disp(X);
% end
% 
% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
% targetsTrain=zeros(3,size(trainY,2));
% for i=1:size(trainY,2)
%     targetsTrain(trainY(i),i)=1;
% end
% targetsTest=zeros(3,size(testY,2));
% for i=1:size(testY,2)
%     targetsTest(testY(i),i)=1;
% end
% 
% %transformar dataset de matrix para cells
% trainX=num2cell(trainX,1);
% testX=num2cell(testX,1);
% targetsTrain=num2cell(targetsTrain,1);
% targetsTest=num2cell(targetsTest,1);
% 
% 
% for layerSize=[10,20,30]
%     %criar network e treinar
%     net = narxnet([1:2],[1:2],layerSize);
%     [Xs,Xi,Ai,Ts] = preparets(net,trainX,{},targetsTrain);
%     rng(1);
%     net = train(net,Xs,Ts,Xi,Ai);
% 
%     %fazer previsao
%     [shiftedTestX,Xi,Ai,shiftedTestY] = preparets(net,testX,{},targetsTest);
%     q=sim(net,shiftedTestX);
%     q=cell2mat(q);
%     q=softmax(q);
%     [M, predY]=max(q);
%     testY=cell2mat(shiftedTestY);
%     [M, testY]=max(testY);
%     [accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
%     X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
%     disp(X);
% end

%---------------------------testar tamanho do auto encoder

% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
% targets=zeros(3,size(trainY,2));
% for i=1:size(trainY,2)
%     targets(trainY(i),i)=1;
% end

% rng(1);
% autoenc = trainAutoencoder(trainX,10,'EncoderTransferFunction','logsig','DecoderTransferFunction','purelin','MaxEpochs',2000);
% XReconstructed = predict(autoenc,testX);
% mseError = mse(testX-XReconstructed)


% net = feedforwardnet([20,10],'trainscg');
% net.layers{1}.transferFcn='purelin';
% net.layers{2}.transferFcn='purelin';
% net.layers{3}.transferFcn='purelin';
% net.trainParam.epochs = 2000; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio   = 0/100;
% net.divideParam.testRatio  = 0/100;
% rng(1);
% [net,tr] = train(net,trainX,trainX);
% XReconstructed = sim(net,testX);
% mseError = mse(testX-XReconstructed)

%-------------------------------autoencoder + NN ou NN só
% rng(1);
% autoenc = trainAutoencoder(trainX,20,'EncoderTransferFunction','logsig','DecoderTransferFunction','purelin','MaxEpochs',2000);
% XReconstructed = predict(autoenc,testX);
% mseError = mse(testX-XReconstructed)
% 
% trainX = encode(autoenc,trainX);
% testX = encode(autoenc,testX);
% net = feedforwardnet(10);
% net.trainParam.epochs = 400; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio   = 0/100;
% net.divideParam.testRatio  = 0/100;
% rng(1);
% [net,tr] = train(net,trainX,targets);
% 
% q=sim(net,testX);
% q=softmax(q);
% [M, predY]=max(q);
% [accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
% X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
% disp(X);
% 
% 
% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
% targets=zeros(3,size(trainY,2));
% for i=1:size(trainY,2)
%     targets(trainY(i),i)=1;
% end
% net = feedforwardnet(10);
% net.trainParam.epochs = 400; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio   = 0/100;
% net.divideParam.testRatio  = 0/100;
% rng(1);
% [net,tr] = train(net,trainX,targets);
% 
% q=sim(net,testX);
% q=softmax(q);
% [M, predY]=max(q);
% [accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
% X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
% disp(X);

%-------------postprocessing do output
% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
% targets=zeros(3,size(trainY,2));
% for i=1:size(trainY,2)
%     targets(trainY(i),i)=1;
% end
% 
% net = feedforwardnet(20);
% net.trainParam.epochs = 100; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio   = 0/100;
% net.divideParam.testRatio  = 0/100;
% rng(1);
% [net,tr] = train(net,trainX,targets);
% 
% q=sim(net,testX);
% q=softmax(q);
% [M, predY]=max(q);
% [accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
% X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
% disp(X);
% 
% for i=[3:5:10:30]
%     q=sim(net,testX);
%     q=softmax(q);
%     [M, predY]=max(q);
%     predY=applyPostprocessing(predY,5);
%     [accuracy, sensibility, specificity] = computeMeasures(predY, testY,1);
%     X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
%     disp(X);
% end


%-------------varias arquiteturas CNN
% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadImages(pacients(2),0.8);
% 
% inputSize = [29 29 1];
% numClasses = 3;

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

% layers = [
%  imageInputLayer(inputSize)
%  convolution2dLayer(3,29)
%  averagePooling2dLayer(2)
%  convolution2dLayer(3,10)
%  reluLayer
%  fullyConnectedLayer(numClasses)
%  softmaxLayer
%  classificationLayer];
% 
% accuracies=[];
% for i=1:5
%     options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
%     rng(i);
%     net = trainNetwork(trainX,trainY,layers,options);
% 
%     predY = predict(net,testX,'ExecutionEnvironment','cpu')';
%     [M, predY]=max(predY);
%     [accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),1);
%     X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
%     disp(X);
% accuracies=[accuracies accuracy];
% end
% 
% disp(mean(accuracies));

%----------lstm c varias configuracoes
% pacients=["../dataset/44202.mat","../dataset/63502.mat"];
% [trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
% trainX = normalize(trainX,'range');
% testX = normalize(testX,'range');
% 
% trainY=categorical(trainY)';
% testY=categorical(testY)';
% trainX=num2cell(trainX,1);
% testX=num2cell(testX,1);
% 
% for HiddenUnits=[5,10,30]
%     accuracies=[];
%     for i=1:5
%         numFeatures = 29;
%         numClasses = 3;
%         layers = [ ...
%             sequenceInputLayer(numFeatures)
%             lstmLayer(HiddenUnits,'OutputMode','last')
%             fullyConnectedLayer(numClasses)
%             softmaxLayer
%             classificationLayer];
% 
%         options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
%         rng(i);
%         net = trainNetwork(trainX,trainY,layers,options);
% 
%         predY = predict(net,testX,'ExecutionEnvironment','cpu')';
%         [M, predY]=max(predY);
%         [accuracy, sensibility, specificity] = computeMeasures(predY,double(testY'),1);
%         X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
%         disp(X);
%         accuracies=[accuracies,accuracy];
%     end
%     disp(mean(accuracies));
% end
