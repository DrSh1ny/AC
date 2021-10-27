function [outputArg1,outputArg2] = runNeuralNetwork(nnType, transferFunction)
%RUNNEURALNETWORK Summary of this function goes here
%   Detailed explanation goes here
    load 'P.mat' P;
    nLayers=1;
    transferFnc="purelin";
    
    if nnType=="Classifier(1 Layer)"
        nLayers=1;
    elseif nnType=="Classifier(2 Layer)"
        nLayers=2;
    elseif nnType=="Classifier(2 Layer)"
        nLayers=2;
    end
    
    if transferFunction=="Linear"
        transferFnc="purelin";
    elseif transferFunction=="HardLim"
        transferFnc="hardlim";
    elseif transferFunction=="Sigmoidal"
        transferFnc="logsig";
    end
    
    
    outputArg1 = nnType;
    outputArg2 = transferFunction;
end

