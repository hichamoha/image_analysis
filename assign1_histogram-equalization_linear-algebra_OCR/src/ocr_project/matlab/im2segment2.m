function [S] = im2segment2( im )
% im2segment() takes such an image matrix I as input and returns 
% a segmentation, i.e. a set of images S = (S1,...,Sn) one for each 
% letter in the image.

first = 1;
last = 1;
[m,n] = size(im);
kk = 1;
im = im < 125;

% scan image
while last < n-2
    im_black = zeros(m,n);
    
    % Find the left side of the letter
    while ((sum(im(:,first)) < 1) && first < n-2)
        first = first + 1;
    end
    
    % right side of the letter
    last = first;
    while ((sum(im(:,last)) > 0) && last < n-2)
        last = last + 1;
    end

    i = first - 1;
    %i = first;
    j = last + 1;
    %j = last;

    im_black(:,i:j) = im(:,i:j);
    S{kk} = im_black;
    kk = kk + 1;
    first = last;
    

end

