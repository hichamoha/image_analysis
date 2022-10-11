function [S] = myim2segment(im)
% im2segment() takes such an image matrix I as input and returns 
% a segmentation, i.e. a set of images S = (S1,...,Sn) one for each 
% letter in the image.

%nrofsegments = 4; 
%[m,n] = size(image);  % returns the number of rows and columns in
                      % image as separate output variables.
m = size(im,1);
n = size(im,2);

% Note:
% The technique chroma keying, is widely used for removing a single-colored
% background. Because we know the background color, we can easily remove it, 
% cut the foreground, and use a different image as background.

% thresholding of the intensity (brightness)to segment the foreground
im = im < 125;

% the output must be a cell array
S = cell(1,5); 

% create a label image, where all pixels having the same value
% belong to the same object, i.e letter
% 1 1 0 1 1 0      1 1 0 2 2 0
% 0 1 0 0 0 0      0 1 0 0 0 0
% 0 0 0 1 1 0  ->  0 0 0 3 3 0
% 0 0 1 1 1 0      0 0 3 3 3 0
% 1 0 0 0 1 0      4 0 0 0 3 0
labels = bwlabel(im,8); 
% matrix containing labels for the connected components 
% in im. The elements of labels are integer values greater than 
% or equal to 0. The pixels labeled 0 are the background. 
% The pixels labeled 1 make up one object, the pixels 
% labeled 2 make up a second object, and so on.

%[labels,num] = bwlabel(im); 
% returns in num the number of connected objects found in im.
%num % 5

%for kk = 1:nrofsegments;
for kk = 1:5;
    %S{kk}= (rand(m,n)<0.5);
                                
    [r,c] = find(labels == kk);   % Find indices and values of nonzero elements
    rc = [r c];
    [sx sy] = size(rc);
    blackBg = zeros(m,n);  % each image matrix Si should be with 1 at the  
                           % pixels for that letter and 0 for all other.
    
    for i = 1:sx
        x = rc(i,1);
        y = rc(i,2);
        blackBg(x,y) = im(x,y);
    end
        
    S{kk} = blackBg;

end;

