function [processedPredY] = applyPostProcessing(testY,threshold)
nSamples=size(testY,2);
processedPredY=testY;
for i = threshold+1:nSamples
    
    past=testY(i-threshold:i);
    ones=sum(past==1);
    twos=sum(past==2);
    threes=sum(past==3);
    
    [maxim,idx]=max([ones,twos,threes]);
    processedPredY(i)=idx;
    
end
    
end

