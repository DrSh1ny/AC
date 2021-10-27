function accuracy = accuracy(network,samples,labels)
    q=sim(network,samples);
    [M,I]=max(q);
    predictions=mod(I,10);
    
    equalClassification=sum(predictions==labels);
    nSamples=length(labels);
    
    accuracy=equalClassification./nSamples;
end

