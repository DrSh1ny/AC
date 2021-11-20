pacients=["../dataset/44202.mat","../dataset/63502.mat"];
[trainX,trainY,testX,testY]=loadDataset(pacients(2),0.8);
targets=zeros(3,size(trainY,2));
for i=1:size(trainY,2)
    targets(trainY(i),i)=1;
end

rng(1);
autoenc = trainAutoencoder(trainX,10,'EncoderTransferFunction','logsig','DecoderTransferFunction','purelin','MaxEpochs',2000);
XReconstructed = predict(autoenc,testX);
mseError = mse(testX-XReconstructed)


% net = feedforwardnet([20,10],'trainscg');
% net.layers{1}.transferFcn='purelin';
% net.layers{2}.transferFcn='purelin';
% net.layers{3}.transferFcn='purelin';
% net.trainParam.epochs = 2000; % maximum epochs
% net.divideFcn='dividerand';
% net.divideParam.trainRatio = 100/100;
% net.divideParam.valRatio   = 0/100;
% net.divideParam.testRatio  = 0/100;
% rng(1);
% [net,tr] = train(net,trainX,trainX);
% XReconstructed = sim(net,testX);
% mseError = mse(testX-XReconstructed)


save('../networks/autoencoder','autoenc')