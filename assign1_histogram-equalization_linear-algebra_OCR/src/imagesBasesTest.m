%% imagesBasesTest: 
% This is a testscript for testing all of the 400 test images in a test set 
% and returns the mean of the error norms. Calculate this mean for each of 
% the 2 test sets on each of the three bases. 
clc;
clear all;
load assignment1bases.mat;

%% Plot a few images in each of the 2 test sets
%load assignment1bases.mat;
% The variable stacks is a cell array. It contains two stacks of images:
% 400 test images of faces of size 19×19. These are stored in a variable 
% stacks{1}, which is a three-dimensional data structure of size 19×19×400.
figure(1)
% choose 4 test images among 400
imageIndex = [1 10 20 30];
p = 1;

for i = 1:4
    subplot(2,2,p)
    imagesc(stacks{1}(:,:,imageIndex(i))) % scale data and display as image.
    p = p + 1;
    str1 = sprintf('Test Image from Set 1 at index %d', imageIndex(i));
    title(str1)
end

figure(2)
p = 1;

for i = 1:4
    subplot(2,2,p)
    imagesc(stacks{2}(:,:,imageIndex(i))) % scale data and display as imag
    p = p + 1;
    str2 = sprintf('Test Image from Set 2 at index %d', imageIndex(i));
    title(str2)
end

%% Plot the four images in each of the 3 bases
% The variable bases is a cell array. 
% It contains three sets of bases for 3 different subspaces of 
% dimension 4. The first basis is stored in a variable bases{1}, 
% which is a tensor of size 19X19X4. Thus, the 4 basis images are
% bases{1}(:,:,1),  bases{1}(:,:,2),  bases{1}(:,:,3), bases{1}(:,:,4).
figure(3)
p = 1;
for i = 1:3
    bset = bases{i};
       
    basis1 = bset(:,:,1);
    subplot(3,4,p); 
    imagesc(basis1);
      
    basis2 = bset(:,:,2);
    subplot(3,4,p+1);
    imagesc(basis2);
    str3 = sprintf('The 4 images in the set of bases %d', i);
    title(str3)
       
    basis3 = bset(:,:,3);
    subplot(3,4,p+2);
    imagesc(basis3);
       
    basis4 = bset(:,:,4);
    subplot(3,4,p+3);
    imagesc(basis4);
       
    p = p + 4;
end
       
%% Plot projection of the test images onto the 3 bases
for i = 1:2
    figure(3+i)
    u = stacks{i}(:,:,10);
    subplot(2,2,1)
    imagesc(u);
    str1 = sprintf('Test image from stack %d', i);
    title(str1)
    
    for j = 1:3
        [up] = project(u,bases{j});
        subplot(2,2,j+1)
        imagesc(up);
        str2 =sprintf('The projected image onto basis %d', j);
        title(str2)
    end
    
end

%% The mean of the error norms for the 6 combinations
% (2 test sets against the 3 bases)

% mean values
meanSet1 = [0 0 0];
meanSet2 = [0 0 0];

% error norms
normSet1 = zeros(1,400); 
normSet2 = zeros(1,400);

% test images 
imageSet1 = stacks{1};
imageSet2 = stacks{2};

for i = 1:3
    basis = bases{i};
    
    for j = 1:400
        [up1,r1] = project(imageSet1(:,:,j), basis);
        [up2,r2] = project(imageSet2(:,:,j), basis);
        normSet1(j) = r1;
        normSet2(j) = r2;
    end
    
    % Calculate the mean value of the error norms.
    meanSet1(i) = mean(normSet1);
    meanSet2(i) = mean(normSet2);
end

disp(['Mean of the error norms for test set 1:  ' num2str(meanSet1)]);
disp(['Mean of the error norms for test set 2:  ' num2str(meanSet2)]);
        
% Result of the mean of the error norms for the 6 combinations
% 2 test sets against 3 bases
% meanSet1 = 821.0271  860.4754  944.9009
% meanSet2 = 795.1902  649.2013  697.3214
        









   
    
    
    
    
    