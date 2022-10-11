
                % Handin 4 - Task 4
                % fucnction segment2features2(S)
%{
  Here we implement an algorithm for calculating a feature vector x from a
segment S. From the previous assignments, this function has been
constructed and now we need to try improving the code to make it as good 
as possible. So we need to change the system and produce a version 2 that 
works better on the five datasets (short1, short2, home1, home2, home3). 
                
NOTE: Szeliski 14.4 
The problem of searching for features (patterns) in data is a fundamental 
one. The major goal of image feature extraction is that given an image, 
or a region within an image, generate the features that will subsequently 
be fed to a classifier in order to classify the image in one of the possible 
classes.
 
Feature selection
• A number of feature candidates may have been generated 
• Using all candidates will easily lead to over traing (unreliable 
  classification of new data)
• Dimmensionality reduction is required, i.e. feature selection!
• Exhaustive search impossible!
• Trial and error (select feature combination, train classifier estimate
 error rate).
• Suboptimal search 
• «Branch and Bound» search algorithm
•Linear or non-linear mappings to lower dimensional feature space
%}

function features = segment2features2(B)

% initialize the features vector x
%features = randn(6,1);
features = ones(7,1);

% Given a binary image B (thus only with zeros and ones), 1 => object pixel
% 0 => background pixel. So an object in a binary image is a set of white 
% pixels (ones) that are connected to each other.
% study the region of pixels that are equal to 1. 
% Use your imagination to define at least 6 different features (numbers),
% that can be used to classify which letter the region corresponds to.

% region of interest: Identify the region of pixels that are equal to one
[y x] = find( B == 1 );
xmax = max(x); 
xmin = min(x);
ymax = max(y); 
ymin = min(y);
regionOfB = B(ymin:ymax,xmin:xmax);

% size of the image region
[m,n] = size(regionOfB);

%              ####### Features extraction  #########
   
              % Feature 1: the sum of pixel values
              % Feature 2: the left vertical half of the image
              % Feature 3: the upper horizontal half of the image
              % Feature 4: the under horizontal half of the image
              
              % Some region properties
                    % prop 1: Area of smallest convex polygon
                    % prop 2: Pixelsum of the box that contains the letter
                    % prop 3: Center of mass
                    % prop 4: Circumfere properites
                    % prop 5: equal diameter
                    % prop 6: Filled area
                    % prop 7: Mean of convex hull pixels which will be added to the hitrate
                    % prop 8: Minor and major axis 
              % Feature 5: calculate the norm of the features
             

i = 1;

% Feature 1: the sum of pixel values
features(i) = sum(sum(regionOfB))/(m*n);
i = i + 1;

% Feature 2: the left vertical half of the image 
n2 = ceil(n/2);
features(i) = sum(sum(regionOfB(:,1:n2))) / (m*n2);
i = i + 1;
% Feature 3: the upper horizontal half of the image
m2 = ceil(m/2);
features(i) = sum(sum(regionOfB(1:m2,:))) / (m2*n);
i = i + 1;
% Feature 4: the under horizontal half of the image 
features(i) = sum(sum(regionOfB(m2:m,:))) / (m2*n);
i = i + 1;


% calculate region properties of objects in the image
%{
Using the binary image, we can then calculate region properties of objects 
in the image, such as area, diameter, etc... 
Using the regionprops() command to obtain quantitative information about 
the objects:
    D = regionprops(L, properties)
There is a lot of useful statistical information about objects that can be 
extracted using regionprops
%}
reg = regionprops(regionOfB,'all');

% prop 1: Area of smallest convex polygon
features(i) = reg.ConvexArea / (m*n);
i = i + 1;

% prop 2: Pixelsum of the box that contains the letter
bb = reg.BoundingBox;
features(i) = sum(bb) / m;
i = i + 1;

% prop 3: Center of mass
cent = reg.Centroid;
features(i) = cent(2) / m;
i = i + 1;
features(i) = cent(1) / n;
i = i + 1;

% prop 4: Circumfere properites
if reg.PerimeterOld ~= 0
    features(i) = reg.Perimeter / reg.PerimeterOld;
    i = i + 1;
else
    features(i) = reg.Perimeter / (m+n);
    i = i + 1; 
end

% prop 5: equal diameter
features(i) = reg.EquivDiameter / (n);
i = i + 1;

% prop 6: Filled area
features(i) = reg.FilledArea / (m*n);
i = i + 1;

% prop 7: Mean of convex hull pixels which will be added to the hitrate
hull = reg.ConvexHull;
hull = mean(hull(:,1))/(m);
features(i) = hull;
i = i + 1;

% prop 8: Minor and major axis 
features(i) = reg.MinorAxisLength / reg.MajorAxisLength;
i = i + 1;


% Feature 5: calculate the norm of the features
features(i) = norm(features);
i = i + 1;

end

