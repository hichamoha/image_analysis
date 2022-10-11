
        % OCR - Feature Extraction
        % FMAN20 - Image Analysis - Handin 2
        % Hicham Mohamad - hsmo@kth.se
%{
        
Read also: Szeliski 14.4 
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
• «Branch and Bound» search 
•Linear or non-linear mappings to lower dimensional feature space
%}

function x = mySegment2features(B)
% features = segment2features(I)

% initialize the features vector x
%features = randn(6,1);
%x = zeros(9,1);
x = zeros(7,1);

% Given a binary image B (thus only with zeros and ones), 1 => object pixel
% 0 => background pixel.
% study the region of pixels that are equal to 1. 
% Use your imagination to define at least 6 different features (numbers),
% that can be used to classify which letter the region corresponds to.

% Localisation: Identify the region of pixels that are equal to one
[yPosition xPosition] = find( B == 1 );
xmax = max(xPosition); 
xmin = min(xPosition);
ymax = max(yPosition); 
ymin = min(yPosition);
regionOfB = B(ymin:ymax,xmin:xmax);

% size of the image region
[m,n] = size(regionOfB);

% Features extraction
i = 1;

% Feature 1: moment
% SIGMA = moment(X,ORDER) returns the ORDER-th central sample moment of
% the values in X.  For vector input, SIGMA is MEAN((X-MEAN(X)).^ORDER).
% For a matrix input, moment(X,ORDER) returns a row vector containing the
% central moment of each column of X.
x(i) = mean(moment(regionOfB,3));
i = i + 1;

%{
% Feature 2: vertical histogram
%n2 = floor(n/2);
n2 = ciel(n/2);
%if n2 == 0        % XXXXX
%    n2 = n2 + 1;
%end
% A histogram is the frequency of occurrence vs. gray level
x(i) = sum(sum(regionOfB(:,n2:n)));      % XXXXXX
i = i + 1;
%}

% Feature 3: the sum of pixel values 
x(i) = sum(sum(regionOfB));
i = i + 1;

% Feature 4: Center of mass
% STATS = regionprops(BW,PROPERTIES) measures a set of properties for
% each connected component (object) in the binary image BW, which must be
% a logical array; it can have any dimension. 
% Calculate centroids for connected components in the image
stats = regionprops(regionOfB,'Centroid');
sx = stats.Centroid(1);
sy = stats.Centroid(2);
x(i) = sx + sy;
i = i + 1;

% Feature 5: Orientation
% Angle between the x-axis and the major axis of the ellipse that has the 
% same second-moments as the region, returned as a scalar. 
% The value is in degrees.
stats = regionprops(regionOfB,'Orientation');
x(i) = abs(stats.Orientation);
i = i + 1;

%{
% Crossing feature 6: Scan through the rows and columns to obtain the 
% horizontal and vertical crossing times of a character.

% Vertical crossings: for any column j = 0,1,2,...,n
% number of vertical crossings in column j
numVerCross = 0;
pixel = 0;
j = 0;
% for any row j = 0,1,2,...,n
while j < m
    while pixel == 0 && j < m
        j = j + 1;
        pixel = regionOfB(j,floor(n/2)); 
        % floor(X) rounds the elements of X to the 
        % nearest integers towards minus infinity.
    end
    
    while pixel == 1 && j < m
        j = j + 1;
        pixel = regionOfB(j,floor(n/2));
    end
    
    numVerCross = numVerCross + 1;
end

if pixel == 0
    numVerCross = numVerCross - 1;
end

% Horizontal crossings
% number of horizontal crossings in row i
numHorCross = 0;
pixel = 0;
j = 0;

% for any column j = 0,1,2,...,n
while j < n
    while pixel == 0 && j < n
        j = j + 1;
        pixel = regionOfB(floor(m/2),j);
    end
    
    while pixel == 1 && j < n
        j = j + 1;
        pixel = regionOfB(floor(m/2),j);
    end
    
    numHorCross = numHorCross + 1;
end

if pixel == 0
    numHorCross = numHorCross - 1;
end

x(i) = (numHorCross + numVerCross);
i = i + 1;
%}

% Feature 7: Number of holes using bwEuler() function
% EUL = bweuler(BW,N) returns the Euler number for the binary
% image BW. EUL is a scalar whose value is the number of
% objects in the image minus the total number of holes in those
% objects.  N can have a value of either 4 or 8, where 4
% specifies 4-connected objects and 8 specifies 8-connected
% objects; if the argument is omitted, it defaults to 8. 
x(i) = bweuler(regionOfB);
i = i + 1;

% Feature 8: Average of row sum
% S = mean(X) is the mean value of the elements in X if X is a vector. 
% For matrices, S is a row vector containing the mean value of each column.
x(i) = mean(sum(regionOfB'));
i = i + 1;

% Feature 9: Average of column sum
x(i) = mean(sum(regionOfB));
i = i + 1;

end

