function [Y] = myclassify(X,filled_inx)
%MYCLASSIFY Summary of this function goes here
%   Detailed explanation goes here
size(X)
load net.mat net
q=sim(net,X(:,filled_inx));
q
[M,I]=max(q);
Y=mod(I,10);
Y
end

