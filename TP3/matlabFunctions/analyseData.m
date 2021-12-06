historyR=[];
historyB=[];
historyG=[];
path="../Maturity/Class";
for i=1:6
    class=append(" ",num2str(i));
    class=append(class,"/");
    class=append(path,class)
    [r,g,b]=datasetTransformation(class);
    historyR=[historyR, r];
    historyB=[historyB, b];
    historyG=[historyG, g];
end

scatter(1:6,historyR,10,'red');
hold on;
scatter(1:6,historyG,10,'green');
hold on;
scatter(1:6,historyB,10,'blue');