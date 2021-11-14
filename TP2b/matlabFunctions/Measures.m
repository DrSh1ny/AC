function [sensibility, specificity] = Measures( testY, predY)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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

