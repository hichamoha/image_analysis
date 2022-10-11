                
                 % Find the errors
                 % Image Analysis - FMAN20
                 % Assignment 4 - problem 1
                 % Hicham Mohamad - hsmo@kth.se


clc; close all; clear; 
load femfel

figure(1); 
imshow([femfel1, femfel2]), title('Original images')

% Display the difference of femfel1 and femfel2.
figure(2), imshowpair(femfel1, femfel2, 'diff')
title('the difference of femfel1 and femfel2')

%% convert to grayscale images
gray1 = rgb2gray(femfel1);
gray2 = rgb2gray(femfel2);
%figure(2)
%imshow([gray1, gray2]), title('Grayscale images')

graydiff = gray2 - gray1;
figure(22), imshow(graydiff);
title('The differences between the two images')

%% cross-correlation function
%{
The output of this cross-correlation function is a matrix b that is the sum 
of the size of the two input images. b has a single maximum, which is 
offset from the center of the matrix by a small amount. This offset 
corresponds to the translation of im1 with respect to im2. To determine 
the location of this peak, we use the find command, which returns the 
locations of nonzero indices in a given matrix.
%}

im1 = rgb2gray(femfel1);
im2 = rgb2gray(femfel2);

b = normxcorr2(im1,im2);
figure(23); mesh(b);
title('The cross-correlation function on the two images')

% find the maximum point of this matrix:
[y,x] = find(b == max(b(:)));

% determine the offset of these positions from the origin of the matrix:
[yc,xc] = size(im2);
yoff = y - yc;
xoff = x - xc;

%% Perform the registration
%movingRegistered = imregister(gray2,gray1,'translation',optimizer,metric);
%{
movingRegistered = imregister(moving,fixed,transformType,optimizer,metric);
transforms the 2-D or 3-D image, moving, so that it is registered with the 
reference image, fixed. Both moving and fixed images must be of the same 
dimensionality, either 2-D or 3-D. transformType is a string scalar or 
character vector that defines the type of transformation to perform. 
optimizer is an object that describes the method for optimizing the metric. 
metric is an object that defines the quantitative measure of similarity 
between the images to optimize. Returns the aligned image, moving_reg.
%}

%  transforms the 2-D or 3-D image, moving, so that it is registered with 
% the reference image, fixed.
fixed = im1;
moving = im2;

% Use imregconfig to create the default metric and optimizer for a capture 
% scenario in one step.
%{
Alternatively, you can create the objects individually. This enables you 
to create alternative combinations to address specific registration issues. 
The following code creates the same monomodal optimizer and metric 
combination.

optimizer = registration.optimizer.RegularStepGradientDescent();
metric = registration.metric.MeanSquares();

%}
[optimizer,metric] = imregconfig('monomodal');
%movingRegistered = imregister(moving, fixed, 'translation', optimizer, metric);

% the 'similarity' transformation types always involve nonreflective 
% transformations.
% The transformed image, movingRegistered, returned as a matrix. 
% Any fill pixels introduced that do not correspond to locations in 
% the original image are 0.
movingRegistered = imregister(moving, fixed, 'similarity', optimizer, metric);


% View the registered images
figure(24), imshowpair(fixed,movingRegistered, 'Scaling','joint')
%figure(24), imagesc(movingRegistered)
title('The output results of the registration using imregister()')

figure(25), imshowpair(fixed,movingRegistered, 'diff')
title('The difference after the registration using imregister()')

%diffreg = fixed - movingRegistered;
diffreg = movingRegistered - fixed;
%figure(225), colormap(gray), imagesc(diffreg)

%% Image histograms and manual thresholding
%{
We need to choose a threshold value T that properly separates light objects 
from the dark background. Image histograms provide a means to visualize the 
distribution of grayscale intensity values in the entire image. 
They are useful for estimating background values, determining thresholds, 
and for visualizing the effect of contrast adjustments on the image. 
The matlab function to visualize image histograms is imhist
%}
figure(26)
imhist(diffreg)
title('The distribution of grayscale intensity values in the diff image')
% A good value for T can be obtained by visually inspecting the image 
% histogram obtained using the imhist command. Based on the histogram, 
% we pick a grayscale value manually that separates the light differences 
% or objects in interest from the dark background. 
% thresholding manually
bwdiffreg = diffreg > 55;
figure(255), colormap(gray), imshow(bwdiffreg)
title('The thresholding result of grayscale intensity values in the diff image')

%% automatic thresholding
level = graythresh(diffreg);
imb = im2bw(diffreg,level);
figure(27), imshow(imb)

%% remove disturbances
% Remove objects containing fewer than 20 pixels and 8-connected
%bw2 = bwareaopen(imb,30,8);
%figure(28), imshowpair(imb,bw2,'montage')
bw2 = bwareaopen(bwdiffreg,40,8);
%figure(28), imshowpair(bwdiffreg,bw2,'montage')
figure(28), imshow(bw2), title('The cleaned differences')

% creates a rectangular structuring element, where mn specifies the size. 
se = strel('square',4);
% Dilate the image with a vertical line structuring element and compare 
% the results.

bw3 = imdilate(bw2,se);
figure(29), imshow(bw3), title('The dilated differences')


%% calculate region properties of objects in the image
%{
Using the binary image, we can then calculate region properties of objects 
in the image, such as area, diameter, etc... 
An object in a binary image is a set of white pixels (ones) that are 
connected to each other. We can enumerate all the objects in the figure 
using the bwlabel command:
    [L, num] = bwlabel(f)
where L gives the labeled image, and num gives the number of objects. 
To label the binary image type:
    [L, N] = bwlabel(imb);
Now look at the labeled image L using imtool. 
What are the values of the objects in the pixels?
Adjust the contrast to see the range of intensity values in the image.
Once the image has been labeled, use the regionprops command to obtain 
quantitative information about the objects:
    D = regionprops(L, properties)
There’s a lot of useful statistical information about objects that can be 
extracted using regionprops
%}

[L, N] = bwlabel(bw3);
bb = regionprops(L, 'BoundingBox', 'Area');
figure(299), imshow(bw3)
% imtool provides access to several other tools for navigating and exploring 
% images, such as the Pixel Region tool, Image Information tool, and the 
% Adjust Contrast tool.
%imtool(bw3)
hold on

for i=1:size(bb)
    rectangle('position',bb(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth',2)
end


%% using imtool to localize the positions
posx = [402, 285, 244, 319, 27, 177];
posy = [330, 246, 182, 117, 310, 179];
for i=1:length(posx)
 rectangle('position',[posx(i) posy(i) 10 10], 'EdgeColor', 'b', 'LineWidth',2)
end

%figure(31) , imshowpair(imb,bw3,'montage')

