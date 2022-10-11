%% Task 1: Image Sampling
% TO DO: The image should have 5x5 pixels and range from 0 to 15 in pixel
% values.
% data1 contains a realization of 100 measurements of white noise 
% with variance 1 and unknown expected value m.

clc; clf;
clear all;

%% Task 2: Histogram Equalization
% TO DO: $p_r(t) = (e^t-1)/(e-2)$, and calculate he result from the
% integral.

%% Task 5: Dimensionality
% TO DO: Here I would like an example of what the basis e1, . . . , ek.
% (both for A and B) could look like.

%% Task 6: Scalar products and norm on images
% TO DO: The scalar products between (u,v) and (u,w) are wrong.
% Orthonormality is a property of a set of matrices/vectors/functions etc. 
% The question is whether v and w is an orthonormal pair.
%What is the orthogonal projection of u on the subspace spanned by {v, w}?
u = [1 -3; 4 -1];
v = 1/2*[1 1; -1 -1];
w = 1/2*[1 -1; 1 -1];

% Frobenius norm (element-wise)
unorm =  norm(u,'fro')
vnorm =  norm(v,'fro')
wnorm =  norm(w,'fro')

% NOTE: dot treats the columns of matrix A and B as vectors and calculates 
% the dot product of corresponding columns. 
% So, for example, C(1) = 54 is the dot product of A(:,1) with B(:,1).
% Frobenius inner product (element-wise)
uv = sum(sum(u .* v))
uw = sum(sum(u .* w))
vw = sum(sum(v .* w))

% the orthogonal projection of u on the subspace spanned by {v,w}
x1 = uv
x2 = uw
upi = x1*v + x2*w

%% Task 7: Image Compression
% Show that these 4 images are orthonormal and determine the 4 coordinates
% x1,x2,x3,x4 such that the approximate image fa is as close to f as
% possible, i.e. such that the MSE = |f - fa|^2, the mean square error, 
% is as small as possible, where
% fa = x1 fi1 + x2 fi2 + x3 fi3 + x4 fi4
clear all;

fi = [];
fi(:,:,1) = 1/3*[0 1 0; 1 1 1; 1 0 1; 1 1 1];
fi(:,:,2) = 1/3*[1 1 1; 1 0 1; -1 -1 -1; 0 -1 0];
fi(:,:,3) = 1/2*[1 0 -1; 1 0 -1; 0 0 0; 0 0 0];
fi(:,:,4) = 1/2*[0 0 0; 0 0 0; 1 0 -1; 1 0 -1];

fi1norm =  norm(fi(:,:,1),'fro')
fi2norm =  norm(fi(:,:,2),'fro')
fi3norm =  norm(fi(:,:,3),'fro')
fi4norm =  norm(fi(:,:,4),'fro')

% here we need to calculate Frobenius inner product, i.e. element-wise
% product of matrices
fi1dotfi2 = sum(sum(fi(:,:,1).*fi(:,:,2)))
fi1dotfi3 = sum(sum(fi(:,:,1).*fi(:,:,3)))
fi1dotfi4 = sum(sum(fi(:,:,1).*fi(:,:,4)))
fi2dotfi3 = sum(sum(fi(:,:,2).*fi(:,:,3)))
fi2dotfi4 = sum(sum(fi(:,:,2).*fi(:,:,4)))
fi3dotfi4 = sum(sum(fi(:,:,3).*fi(:,:,4)))

f = [-2 6 3; 13 7 5; 7 1 8; -3 4 4];

% Calculate x1,x2,x3,x4 for the image f
% x(i) = fi(i)'* f = fi(i).f
x = [];
for i = 1:4
    %x(i) = sum(sum(f.*fi(:,:,i))); % this do the same
    basis = fi(:,:,i);
    x(i) = f(:)'* basis(:);

end
 
disp(['The four coordinates are: ' num2str(x)])
% the approximate image
fa = x(1)*fi(:,:,1) + x(2)*fi(:,:,2) + x(3)*fi(:,:,3) + x(4)*fi(:,:,4);
disp(fa)

