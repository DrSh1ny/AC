
[trainX,trainY,testX,testY]=loadDataset("../dataset/44202.mat",0.8);
trainY(find(trainY==3))=1;
testY(find(testY==3))=1;
targets=zeros(2,size(trainY,2));
for i=1:size(trainY, 2)
    targets(trainY(i),i)=1;
end

autoenc = trainAutoencoder(trainX);
XReconstructed = predict(net,testX);
mseError = mse(testX-XReconstructed)


[accuracy, sensibility, specificity] = Measures(autoenc, testX, XReconstructed);
X = sprintf(' Accuracy: %.4f \n Sensibility %.4f \n Specificity %.4f',accuracy, sensibility, specificity);
disp(X);