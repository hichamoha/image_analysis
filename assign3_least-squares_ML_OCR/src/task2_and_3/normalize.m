function [ Xnormal, mu, sigma ] = normalize( X )

% calculate the mean value
mu = mean(X);
% calculate the standard deviation sigma
sigma = std(X);

% measure the distance of a data point from the mean 
% The standardized data set has mean 0 and standard deviation 1
Xdistance = X - mu; 
Xnormal = Xdistance / sigma;

end

