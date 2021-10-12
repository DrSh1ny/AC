function [Y] = myclassify(X,filled_inx)
%MYCLASSIFY Summary of this function goes here
%   Detailed explanation goes here

%Return a 1x256 
Y=X'
Y=Y(filled_inx)+2
end

