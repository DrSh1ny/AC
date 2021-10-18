load P.mat P


rangeInp=[0 1];
rangeInp=repmat(rangeInp,256,1);
net.inputs{1}.size=256;
net.inputs{1}.range=rangeInp;



net.performParam.lr = 0.5; % learning rate
net.trainParam.epochs = 1000; % maximum epochs
net.trainParam.show = 40; % show
net.trainParam.goal = 1e-6; % goal=objective

nAmostras=1000;
t = eye(10);
t=repmat(t,1,100);

net=train(net,P(:,1:nAmostras),t(:,1:nAmostras));

q=sim(net,P);

