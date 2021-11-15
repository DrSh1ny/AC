function [accuracy, sensitivity, specificity] = Measures(net, testX, testY,detectionMode)

%Accuracy
q=sim(net,testX);
q=softmax(q);
[M, predY]=max(q);
equalClassification=sum(predY==testY);
nSamples=length(testY);
accuracy=equalClassification./nSamples;


%Sensibility and Specificity
mat = confusionmat(testY, predY)


if detectionMode==1
    tp=sum((predY==2) & (testY==2));
    fp=sum((predY==2) & (testY~=2));
    tn=sum((predY~=2) & (testY~=2));
    fn=sum((predY~=2) & (testY==2));
else
    tp=sum((predY==1) & (testY==1));
    fp=sum((predY==1) & (testY~=1));
    tn=sum((predY~=1) & (testY~=1));
    fn=sum((predY~=1) & (testY==1));
end

sensitivity = tp ./(tp + fn);
specificity = tn ./(tn + fp);


end

