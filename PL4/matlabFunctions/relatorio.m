%-----------Network 1 Layer Hard Limit--------------
for k=1:5
    net = perceptron;
    net.trainParam.epochs = 200; % maximum epochs
    net.divideFcn='dividerand';
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio   = 10/100;
    net.divideParam.testRatio  = 10/100;

    load 'dataset.mat'
    [numRows,nAmostras] = size(totalX);
    t = zeros(10,nAmostras);
    for i=1:nAmostras
        if(totalY(i)==0)
            t(10,i)=1;
        else
            t(totalY(i),i)=1;
        end
    end

    rng(k);
    net=train(net,totalX,t);
    disp(testNeuralNetwork(net,testX,testY));
    save  'None_1_Hard Limit' net;
end