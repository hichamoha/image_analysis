function [S] = im2segment2(im)
% [S] = im2segment(im)

% nrofsegments = 4;
% m = size(im,1);
% n = size(im,2);
% for kk = 1:nrofsegments;
%     S{kk}= (rand(m,n)<0.5);
% end;
start_index = 1;
end_index = 1;
[m,n] = size(im);

kk =  1;
im = im <= 107;   % XXXXXX instead of 150 it is decreased to 107

% Scan image
while end_index < n-2
    im_black = zeros(m,n);
    %Find where to cut the image on the left side of the letter
    while ((sum(im(:,start_index)) < 1 ) && start_index < n-2)
        start_index = start_index + 1;
    end
    
    % Find where to cut on the right side of the letter
    end_index = start_index;
    while ((sum(im(:,end_index)) > 0) && end_index < n-2)
        end_index = end_index + 1;
    end
    
    i = start_index -1;
    j = end_index + 1;
    
    im_black(:,i:j) = im(:,i:j);

    % If the sum of white pixels is less than 10, don't add the segment
    if (sum(sum(im_black)) > 10)
        S{kk} = im_black;
        kk = kk + 1;
    end
    
    start_index = end_index;
end


end