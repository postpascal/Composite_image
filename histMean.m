function [ mean ] = histMean( hist )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
 mean = 0;
 for i=1 : length(hist)
     mean = mean + i*hist(i);
 end
 
end

