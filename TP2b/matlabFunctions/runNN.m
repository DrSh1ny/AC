function [sensitivity ,specificity] = runNN(Pacient , NeuralNetwork, DetectionMode, trainMode)
    
    NeuralNetworks = ["FeedForward", "DynamicNN", "CNN", "LSTM"];
    prob = 0.8;
    
    net = append(Pacient, '_');
    net = append(net, NeuralNetwork);
    net = append(net, '_');
    net = append(net, int2str(DetectionMode));
    netName = append(net, '.mat');
    
    rng_value = 1;
    
    Pacient = append("../dataset/",Pacient);
    disp(NeuralNetworks(1))
    disp(NeuralNetwork)
    if NeuralNetwork == NeuralNetworks(4)
        [trainX,trainY,testX,testY]=loadDataset(Pacient,prob);
        
        trainX = normalize(trainX,'range');
        testX = normalize(testX,'range');

        trainY=categorical(trainY)';
        testY=categorical(testY)';
        trainX=num2cell(trainX,1);
        testX=num2cell(testX,1)
        
        if trainMode == 1
            numFeatures = 29;
            numClasses = 3;
            HiddenUnits= 10;
            layers = [ ...
            sequenceInputLayer(numFeatures)
            lstmLayer(HiddenUnits,'OutputMode','last')
            fullyConnectedLayer(numClasses)
            softmaxLayer
            classificationLayer];

            options = trainingOptions('sgdm','MaxEpochs',50,'Verbose',false,'Plots','training-progress','ExecutionEnvironment','cpu');
            rng(rng_value);
            net = trainNetwork(trainX,trainY,layers,options);
            save(netName, 'net')
        else
            %function network
            load(netName, 'net');
            net = network(net);
        end
        
        
        predY = predict(net,testX,'ExecutionEnvironment','cpu')';
        [~, predY]= max(predY);
        [~, sensitivity, specificity] = computeMeasures(predY,double(testY'),1);
        
    elseif NeuralNetwork == NeuralNetworks(3)
        [trainX,trainY,testX,testY]=loadImages(Pacient,prob);
        
        if trainMode == 1
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
            rng(rng_value);
            net = trainNetwork(trainX,trainY,layers,options);
            save(netName, 'net')
        else
            %function network
            load(netName, 'net');
            net = network(net);
        end
        
        predY = predict(net,testX,'ExecutionEnvironment','cpu')';
        [~, predY]= max(predY);
        [~, sensitivity, specificity] = computeMeasures(predY,double(testY'), DetectionMode);
        
        
    elseif NeuralNetwork == NeuralNetworks(2)
        [trainX,trainY,testX,testY]=loadDataset(Pacient,prob);
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
        
        if trainMode == 1
            %criar network e treinar
            net = narxnet([1:2],[1:2],10);
            [Xs,Xi,Ai,Ts] = preparets(net,trainX,{},targetsTrain);
            rng(rng_value);
            net = train(net,Xs,Ts,Xi,Ai);
            
            save(netName, 'net')
        else
            %function network 
            load(netName, 'net');
            net = network(net);
        end
        
        
        
        %     fazer previsao
        [shiftedTestX,Xi,Ai,shiftedTestY] = preparets(net,testX,{},targetsTest);
        q=sim(net,shiftedTestX);
        q=cell2mat(q);
        q=softmax(q);
        [~, predY]=max(q);
        testY=cell2mat(shiftedTestY);
        [~, testY]=max(testY);
        [~, sensitivity, specificity] = computeMeasures(predY, testY,DetectionMode);
        
    elseif NeuralNetwork == NeuralNetworks(1)
        [trainX,trainY,testX,testY]=loadDataset(Pacient,prob);
        targets=zeros(3,size(trainY,2));
        for i=1:size(trainY,2)
            targets(trainY(i),i)=1;
        end
        
        if trainMode == 1
            net = feedforwardnet([20 10]);
            net.trainParam.epochs = 100; % maximum epochs
            net.divideFcn='dividerand';
            net.divideParam.trainRatio = 100/100;
            net.divideParam.valRatio   = 0/100;
            net.divideParam.testRatio  = 0/100;
            rng(rng_value);
            [net,~] = train(net,trainX,targets);
            
            save(netName, 'net')
        else
            %function network 
            load(netName, 'net');
            net = network(net);
        end
        
        q=sim(net,testX);
        q=softmax(q);
        [~, predY]=max(q);
        [~, sensitivity, specificity] = computeMeasures(predY, testY, DetectionMode);
        
    else
        disp("Error");
        sensitivity = 0.0;
        specificity = 0.0;
    end
    
end

