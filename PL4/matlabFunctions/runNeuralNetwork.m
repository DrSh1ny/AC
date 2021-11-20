function runNeuralNetwork(filter, layerNumber,activationFunction)
%RUNNEURALNETWORK Summary of this function goes here
%   Detailed explanation goes here
    filters=['None' 'Associative Memory' 'Binary Perceptron'];
    %layerNumbers=['1' '2'];
    %activationFunctions=['Linear' 'Hard Limit' 'Sigmoidal'];
    
    load 'P.mat' P;
    load 'ind.mat' ind;
    
    if filter==filters(1)
        filter=load('Associative Memory_1_Linear.mat');
        Wp=filter.Wp;
        P=Wp*P;
    elseif filter==filters(2)
        filter=load('Binary Perceptron_1_Hard Limit.mat');
        filter=filter.net;
        P=sim(filter,P);
    end
    
    net = append('None', '_');
    net = append(net, layerNumber);
    net = append(net, '_');
    net = append(net, activationFunction);
    net = append(net, '.mat');
  
    
    %#function network 
    load(net, 'net');
    net = network(net);
    
    
    predicts=sim(net,P(:,ind));
    [~,indx]=max(predicts);

    predictedLabels=ones(1,50).*-1;
    predictedLabels(ind)=indx;
    predictedLabels=reshape(predictedLabels,5,10);
    displayPredictions(predictedLabels);
    
end

