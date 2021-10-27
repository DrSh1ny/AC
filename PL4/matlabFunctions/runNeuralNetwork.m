function runNeuralNetwork(filter, layerNumber,activationFunction)
%RUNNEURALNETWORK Summary of this function goes here
%   Detailed explanation goes here
    filters=['None','Associative Memory','Binary Perceptron'];
    layerNumbers=['1','2'];
    activationFunctions=['Linear','Hard Limit','Sigmoidal'];
    
    load 'net_1_sig.mat' net;
    load 'P.mat' P;
    load 'ind.mat' ind;
    
    predicts=sim(net,P(:,ind));
    [~,indx]=max(predicts);

    predictedLabels=ones(1,50).*-1;
    predictedLabels(ind)=indx;
    predictedLabels=reshape(predictedLabels,5,10);
    displayPredictions(predictedLabels);
    
end

