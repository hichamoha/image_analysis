function features = segment2features(I)
% features = segment2features(I)

%features = randn(6,1);

features = zeros(9,1);

% Find region of interest
[y x] = find( I == 1 );
xmax = max(x); xmin = min(x);
ymax = max(y); ymin = min(y);
I2 = I(ymin:ymax,xmin:xmax);

[m,n] = size(I2);

i = 1;

%Feature 1: total pixelsum
features(i) = sum(sum(I2));
i = i + 1;

% Feature 2: crossings 
%vertical crossings
crossing_ver = 0;
pix = 0;
j = 0;
while j < m
    while pix == 0 && j < m
        j = j + 1;
        pix = I2(j,floor(n/2));
    end
    
    while pix == 1 && j < m
        j = j + 1;
        pix = I2(j,floor(n/2));
    end
    
    crossing_ver = crossing_ver + 1;
end

if pix == 0
    crossing_ver = crossing_ver -1;
end

% Feature, horizontal crossings
crossing_hor = 0;
pix = 0;
j = 0;
while j < n
    while pix == 0 && j < n
        j = j + 1;
        pix = I2(floor(m/2),j);
    end
    
    while pix == 1 && j < n
        j = j + 1;
        pix = I2(floor(m/2),j);
    end
    
    crossing_hor = crossing_hor + 1;
end

if pix == 0
    crossing_hor = crossing_hor -1;
end

features(i) = (crossing_hor+crossing_ver);
i = i + 1;

n2 = floor(n/2);

% 3 Feature: vertical histogram
features(i) = sum(sum(I2(:,n2:n)));
i = i + 1;

% 4 Feature: moment
features(i) = mean(moment(I2,3));
i = i + 1;

% 5 Center of mass
stats = regionprops(I2,'Centroid');
sx = stats.Centroid(1);
sy = stats.Centroid(2);
features(i) = sx+sy;
i = i + 1;

% 6 Orientation
stats = regionprops(I2,'Orientation');
features(i) = abs(stats.Orientation);
i = i + 1;

% 7 Number of holes
features(i) = bweuler(I2);
i = i + 1;

% feature 8: average of row sum
features(i) = mean(sum(I2'));
i = i + 1;

% feature 9: average of column sum
features(i) = mean(sum(I2));
i = i + 1;
end

