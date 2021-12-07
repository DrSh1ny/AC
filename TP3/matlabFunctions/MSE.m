function [output] = MSE(array, value)
%MSE Summary of this function goes here
%   Detailed explanation goes here

difference = array - value;
squared = difference.*2;
output = mean(squared);
    
end

