function [accuracy, sensibility, specificity] = Measures(net, testX, testY)

%Accuracy
q=sim(net,testX);
q=softmax(q);
[M, predY]=max(q);
equalClassification=sum(predY==testY);
nSamples=length(testY);
accuracy=equalClassification./nSamples;


%Sensibility and Specificity
mat = confusionmat(testY, predY)
%[tn, fp , fn ,tp] = mat;
arr = mat';
arr = arr(:)';
tn = arr(1);
fn = arr(2);
fp = arr(3);
tp = arr(4);


sensibility = tp ./(tp + fn);
specificity = tn ./(tn + fp);


end

