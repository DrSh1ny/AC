function [mse, accuracy] = MSE(array, value)
%MSE Summary of this function goes here
%   Detailed explanation goes here

difference = array - value;
squared = difference.^2;
mse = mean(squared);

equalClassification = sum(round(array*10) == value*10);
nSamples=length(value);
accuracy=equalClassification./nSamples; 
    
end

