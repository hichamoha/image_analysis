
%                   Image Analysis - Handin 4 - task 2
%                   2 - Segmentation the heart image with Graph Cuts
%                       using Max-flow Min-cut theorm
%                       Hicham Mohamad - hsmo@kth.se   

clear, clc, close all;

load heart_data.mat
%figure(1); clf; 
%imagesc(im)
[M N] = size(im);

%%
figure(2); clf;
% colormap() Set and get current colormap
% gray returns a linear grayscale colormap.
colormap gray
grayheart = imagesc(im);

%% Number of image pixels
n = M*N; 

%{
Let i and j be two image pixel locations. We say that i is a neighbor of j 
if they are adjacent, either horizontally or vertically. 
We write this as j in N_i.
%}
% create the neighbors and the sparse matrix
Neighbors = edges4connected(M,N);
i = Neighbors(:,1);
j = Neighbors(:,2);
lambda = 2;
% create the sparse matrix
A = sparse(i,j,lambda,n,n);

% 1) Estimate the mean and the standard deviation for the 2 distributions.
mu0 = mean(background_values);
mu1 = mean(chamber_values);

sigma0 = std(background_values);
sigma1 = std(chamber_values);

%{
 Now we handle the other two sums in (3). They will be represented with s 
and t connections in the graph (see the lecture notes). 
In the software package we are going to use, these are represented as a 
separate n x 2 matrix:
%}
T = [ ((im(:) - mu0).^2)/sigma0^2 ((im(:) - mu1).^2)/sigma1^2 ]/2;
%T = [ ((im(:) - mu0).^2)/sigma0^2 ((im(:) - mu1).^2)/sigma1^2 ];
T = sparse(T);

% Finally, we solve the minimum cut problem
[E, Theta] = maxflow(A,T);
Theta = reshape(Theta,M,N);
Theta = double(Theta);
Theta = Theta ~= 0;

% And we can now view the output
%imshow(Theta);

im_mincut = im + Theta;

figure(12)
subplot(1,2,1), 
imshow(im), 
title('The original heart image')
subplot(1,2,2), 
imshow(im_mincut), 
title('The segmented two chambers using Maxflow/Mincut')

