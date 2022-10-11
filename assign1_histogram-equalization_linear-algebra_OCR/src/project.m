function [ up, r ] = project( u, e )
% Summary: Write a matlab function that projects an image u onto a basis 
% (e1,e2,e3,e4) and returns the projection up and error norm r, i.e. 
% the norm of the difference r = |u - up|.
% Hicham Mohamad

% set of scalars (x1,x2,x3,x4) initialized to zeros
x = [0 0 0 0];
for i = 1 : 4
    % The variable bases is a cell array. 
    % It contains three sets of bases for 3 different subspaces of 
    % dimension 4. The first basis is stored in a variable bases{1}, 
    % which is a tensor of size 19X19X4. Thus, the 4 basis images are
    % bases{1}(:,:,1),  bases{1}(:,:,2),  bases{1}(:,:,3), bases{1}(:,:,4).
    basis = e(:,:,i);
    x(i) = u(:)'* basis(:);
end

% The projection of an image u onto a basis (e1,e2,e3,e4) can be written as
% u = x1.e1 + x2.e2 + x3.e3 + x4.e4
up = x(1)*e(:,:,1) + x(2)*e(:,:,2) + x(3)*e(:,:,3) + x(4)*e(:,:,4);

% The error norm r = |u - up| 
r = norm(u-up, 'fro');
       
end

