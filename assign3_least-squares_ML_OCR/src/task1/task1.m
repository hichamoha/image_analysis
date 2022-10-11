% Task 1: Fit least squares and total least squares lines to data points.

% Clear up
clc;
close all;
clearvars;

% Begin by loading data points from linjepunkter.mat
load linjepunkter

% Convenient to have x, y as column vectors
x = x';
y = y';
N = length(x); % number of data points

% Plot data
plot(x, y, '*'); hold on;
xlabel('x') 
ylabel('y')
title('Line Fittings with LS and LTS methods') % OBS - CHANGE TITLE!
x_fine = [min(x)-0.05,max(x)+0.05]; % used when plotting the fitted lines

% Fitting line with Least Squares
% Fit a line to these data points with least squares
% Here you should write code to obtain the p_ls coefficients (assuming the
% line has the form y = p_ls(1) * x + p_ls(2)).

% XXXXXXXX TO DO
%p_ls = [rand(), 6]; % REMOVE AND REPLACE WITH LEAST SQUARES

A = [x ones(length(x),1)];
% least squares solution p = [(A'*A)^(-1)]*A'*y
% In matlab the least squares solution can be obtained using the
% slash function (operator). 
p_ls = A\y 

plot(x_fine, p_ls(1) * x_fine + p_ls(2)); 

%  ######    Fitting line with Total Least Squares
% Fit a line to these data points with total least squares.
% Note that the total least squares line has the form 
% ax + by + c = 0, but the plot command requires it to be of the form
% y = kx + m, so make sure to convert appropriately.


% XXXXXXXXXX TO DO
%p_tls = [rand(), 6]; % REMOVE AND REPLACE WITH TOTAL LEAST SQUARES
% here we implement the eigenvalue problem to get the parameters a, b and c
sumx2 = sum(x.^2);
sumxsumx = sum(x)*sum(x);
sumxy = sum(x.*y);
sumxsumy = sum(x)*sum(y);
sumy2 = sum(y.^2);    %*sum(y);   %XXXXXXX
sumysumy = sum(y)*sum(y);

A11 = sumx2 - 1/N*sumxsumx;
A12 = sumxy - 1/N*sumxsumy;
A21 = sumxy - 1/N*sumxsumy;
A22 = sumy2 - 1/N*sumysumy;

A_tls = [A11 A12; A21 A22];
%[~,~,W] = eig(Atls); % [V,D,W] = eig(A) also produces a full matrix W whose 
                     % columns are the corresponding left eigenvectors so 
                     % that W'*A = D*W'.
% here we find the values a,b and c that minimize the sum of squares of the
% distance
[W,D] = eig(A_tls);                     
V = W(:,1,:);                     
a = V(1); 
b = V(2);
c = -1/N*(a*sum(x) + b*sum(y));

% conversion to y = kx + m line form
% ax + by + c = 0 => y = -a/bx + -c/b = y = kx + m
p_tls(1) = -a/b;
p_tls(2) = -c/b;

plot(x_fine, p_tls(1) * x_fine + p_tls(2), 'k--')

% Legend --> show which line corresponds to what (if you need to
% re-position the legend, you can modify rect below)
h=legend('data points', 'least-squares','total-least-squares');
rect = [0.20, 0.65, 0.25, 0.25];
set(h, 'Position', rect)

% Compute the 4 errors
% After having plotted both lines, it's time to compute errors for the
% respective lines. Specifically, for each line (the least squares and the
% total least squares line), compute the least square error and the total
% least square error. Note that the error is the sum of the individual
% errors for each data point! In total you should get 4 errors. Report these
% in your report, and comment on the results. 
% OBS: Recall the distance formula between a point and a line from linear 
% algebra, useful when computing orthogonal errors!

% WRITE CODE BELOW TO COMPUTE THE 4 ERRORS
% Line 1
% compute the least square error
n_ls = abs(y - A*p_ls); 
e_ls = sum(n_ls)

% the total least square errors (orthogonal errors)  XXXXXX TO DO
a1 = p_ls(1); b1 = -1; c1 = p_ls(2);
n1_tls = abs((a1*x + b1*y + c1))/sqrt(a1^2 + b1^2);
e2_tls = sum(n1_tls)

% Line 2
% the total least square errors (orthogonal errors)
n2_tls = abs((a*x + b*y + c))/sqrt(a^2 + b^2);
e2_tls = sum(n2_tls)

% LS solution can be obtained by
n2_ls = abs(y - A*p_tls'); 
e2_ls = sum(n2_ls)
