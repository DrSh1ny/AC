load P.mat P
net = network(1,2,[1;1],[1;0],[0 0;1 0],[0 1]);

net.layers{1}.transferFcn = 'purelin';
net.layers{2}.transferFcn = 'purelin';

rangeInp=[0 1];
rangeInp=repmat(rangeInp,256,1);
net.inputs{1}.size=256;
net.inputs{1}.range=rangeInp;
net.layers{1}.size=20;


net.trainFcn = 'traingda';
net.performParam.lr = 0.5; % learning rate
net.trainParam.epochs = 1000; % maximum epochs
net.trainParam.show = 40; % show
net.trainParam.goal = 1e-6; % goal=objective
net.performFcn = 'sse'; % criterion

nAmostras=900;
t = eye(10);
t=repmat(t,1,90);

net=train(net,P(:,1:nAmostras),t(:,1:nAmostras));

q=sim(net,P);

