%% Get the directory of a dataset
clc;
clear all;

datadir = '../datasets/short1';
a = dir(datadir);

%% Select a filename
file = 'im1'

%% Generate filename with path and extension
fnamebild = [datadir filesep file '.jpg']
fnamefacit = [datadir filesep file '.txt']

%% Read an image and convert to double
bild = double(imread(fnamebild));

%% Read the ground truth interpretation
fid = fopen(fnamefacit);
facit = fgetl(fid)
fclose(fid);

%% Plot the image with ground truth as title

figure(1); colormap(gray);
imagesc(bild(:,1:200));
title(facit);

%% Run your segmentation code
%S = im2segment(bild);
S = myim2segment(bild);
%S = im2segment2(bild);

%% Plot all the segments
figure(2);
for k = 1:length(S);
  colormap(gray);
  imagesc(S{k});   % Display image with scaled colors
  disp(['Segment nr: ' num2str(k) ' out of ' num2str(length(S)) '.']);
  disp('Press a button to continue');
  pause;
end;

%% plot all the segments in a subplot

figure(3)
p = 1;

for i = 1:length(S)
    subplot(5,1,p)
    %suptitle('The resulting segmented images');
    colormap(gray);
    imagesc(S{i}) % Display image with scaled colors
    p = p + 1;
end
