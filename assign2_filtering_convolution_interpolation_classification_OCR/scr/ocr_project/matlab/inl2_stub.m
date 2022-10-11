%% Get the directory of a dataset
clear all
clc

datadir = '../datasets/short1';
a = dir(datadir);

%% Select a filename
file = 'im1';

%% Generate filename with path and extension
fnamebild = [datadir filesep file '.jpg'];
fnamefacit = [datadir filesep file '.txt'];

%% Read an image and convert to double
bild = imread(fnamebild);
%bild = double(imread(fnamebild));

%% Read the ground truth interpretation
fid = fopen(fnamefacit);
facit = fgetl(fid);
fclose(fid);

%% Plot the image with ground truth as title
figure(1); colormap(gray);
imagesc(bild(:,1:200));
title(facit);

%% Run your segmentation code
%S = im2segment(bild);
S = myim2segment(bild);
B = S{1};

%% Plot all the segments
figure(2);
for k = 1:length(S);
  colormap(gray);
  imagesc(S{k});
  disp(['Segment nr: ' num2str(k) ' out of ' num2str(length(S)) '.']);
  disp('Press a button to continue');
  pause;
end;

%% Run your features code
x = mySegment2features(B);
for i = 1:size(x)
    disp(['Feature nr: ' num2str(i) ' out of ' num2str(length(x)) ...
                                                 ': ' num2str(x(i))]);
end

%% display features in table

features = {'Moment';'Vertical Histogram';'Sum of pixels'; 
            'Center of mass';'Orientation';'Crossings'; 
            'Numbre of holes';'Average of row sum';'Average of column sum'};
values = [x(1); x(2); x(3); x(4); x(5); x(6); x(7); x(8); x(9)];
T = table(features,values)


