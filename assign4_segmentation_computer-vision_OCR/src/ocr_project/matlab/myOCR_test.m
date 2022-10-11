
clear, clc, close all
% load the segments S and corresponding letter code y (from 1 to 26) 
load ocrsegments.mat

% Choose dataset
datadirs = cell(1,5);
% Which folder of examples are you going to test it on?
datadirs{1} = '../datasets/short1';
datadirs{2} = '../datasets/short2';
datadirs{3} = '../datasets/home1'; 
datadirs{4} = '../datasets/home2'; 
datadirs{5} = '../datasets/home3'; 


% Prior to running this, make sure you follow the steps / launch the script
% in 'first_steps_handin3_task4.m'.

% Setup the names of the functions of your OCR system. Make sure that all
% of them reside in this same folder of course!
mysystem1.segmenter = 'myim2segment';      % your segmentation-algorithm?
mysystem1.features = 'mySegment2features'; % your features-algorithm?
mysystem1.classifier = 'myFeatures2class'; % your classification-algorithm?

classification_data1 = ocr_class_train(S,y); 
mysystem1.classification_data = classification_data1;

hitrates1 = zeros(1,5);
n = 5;

for i = 1:n 
    datadir = datadirs{i};
    hitrates1(i) = benchmark_inl4(mysystem1, datadir, 0);
end

% Benchmark and visualize
%mode = 2; % debug modes 
% 0 with no plots
% 1 with some plots
% 2 with the most plots || We recommend setting mode = 2 if you get bad
% results, where you can now step-by-step check what goes wrong. You will
% get a plot showing some letters, and it will step-by-step show you how
% the segmentation worked, and what your classifier classified the letter
% as. Press any button to go to the next letter, and so on.
%[hitrate,confmat,allres,alljs,alljfg,allX,allY]=benchmark_inl3(mysystem,datadir,mode);

% Display all hitrates
hitrates1
% Overall hitrate
mean_hitrate1 = mean(hitrates1);
error_rate1 = 1 - mean_hitrate1;

%% version 2 - Assignment 4

% Setup the names of the functions of your OCR system. Make sure that all
% of them reside in this same folder of course!
mysystem2.segmenter = 'myim2segment2';      % your segmentation-algorithm?
mysystem2.features = 'segment2features2'; % your features-algorithm?
mysystem2.classifier = 'myFeatures2class'; % your classification-algorithm?

classification_data2 = ocr_class_train2(S,y); 
mysystem2.classification_data = classification_data2;

hitrates2 = zeros(1,5);
n = 5;

for i = 1:n 
    datadir = datadirs{i};
    hitrates2(i) = benchmark_inl4(mysystem2, datadir, 0);
end

% Benchmark and visualize
%mode = 2; % debug modes 
% 0 with no plots
% 1 with some plots
% 2 with the most plots || We recommend setting mode = 2 if you get bad
% results, where you can now step-by-step check what goes wrong. You will
% get a plot showing some letters, and it will step-by-step show you how
% the segmentation worked, and what your classifier classified the letter
% as. Press any button to go to the next letter, and so on.
%[hitrate,confmat,allres,alljs,alljfg,allX,allY]=benchmark_inl3(mysystem,datadir,mode);

% Display all hitrates
hitrates2
% Overall hitrate
mean_hitrate2 = mean(hitrates2);
error_rate2 = 1 - mean_hitrate2;

