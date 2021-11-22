function [sensitivity ,specificity] = runNN(Pacient , NeuralNetwork, DetectionMode)
    
    NeuralNetworks = ['FeedForward', 'DynamicNN', 'CNN', 'LSTM']
    
    prob = 0.8;
    
    net = append(Pacient, '_');
    net = append(net, NeuralNetwork);
    net = append(net, '.mat');
    
    %function network 
    load(net, 'net');
    net = network(net);
    
    Pacient = append("../dataset/",Pacient);
    
    if NeuralNetwork == NeuralNetworks(3)
        [trainX,trainY,testX,testY]=loadDataset(Pacient,prob);
        
        trainX = normalize(trainX,'range');
        testX = normalize(testX,'range');

        trainY=categorical(trainY)';
        testY=categorical(testY)';
        trainX=num2cell(trainX,1);
        testX=num2cell(testX,1)
        
        predY = predict(net,testX,'ExecutionEnvironment','cpu')';
        [~, predY]= max(predY);
        [~, sensitivity, specificity] = computeMeasures(predY,double(testY'),1);
        
    elseif NeuralNetwork == NeuralNetworks(2)
        [trainX,trainY,testX,testY]=loadImages(Pacient,prob);
        
        predY = predict(net,testX,'ExecutionEnvironment','cpu')';
        [~, predY]= max(predY);
        [~, sensitivity, specificity] = computeMeasures(predY,double(testY'), DetectionMode);
        
        
    elseif NeuralNetwork == NeuralNetworks(1)
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
        
        
        %     fazer previsao
        [shiftedTestX,Xi,Ai,shiftedTestY] = preparets(net,testX,{},targetsTest);
        q=sim(net,shiftedTestX);
        q=cell2mat(q);
        q=softmax(q);
        [~, predY]=max(q);
        testY=cell2mat(shiftedTestY);
        [~, testY]=max(testY);
        [~, sensitivity, specificity] = computeMeasures(predY, testY,DetectionMode);
        
    else
        [trainX,trainY,testX,testY]=loadDataset(Pacient,prob);
        targets=zeros(3,size(trainY,2));
        for i=1:size(trainY,2)
            targets(trainY(i),i)=1;
        end

        q=sim(net,testX);
        q=softmax(q);
        [~, predY]=max(q);
        [~, sensitivity, specificity] = computeMeasures(predY, testY, DetectionMode);
    end
    
end

