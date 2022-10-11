% Prior to running this, make sure you follow the steps / launch the script
% in 'first_steps_handin3_task4.m'.

% Setup the names of the functions of your OCR system. Make sure that all
% of them reside in this same folder of course!
mysystem.segmenter = 'myim2segment'; % What is the name of your segmentation-algorithm?
mysystem.features = 'mySegment2features'; % What is the name of your features-algorithm?
mysystem.classifier = 'myFeatures2class'; % What is the name of your classification-algorithm?

load classification_data
mysystem.classification_data = classification_data;

% Choose dataset
%datadir = '../datasets/short1'; % Which folder of examples are you going to test it on?
datadir = '../datasets/home1'; % Which folder of examples are you going to test it on?

% Benchmark and visualize
mode = 2; % debug modes 
% 0 with no plots
% 1 with some plots
% 2 with the most plots || We recommend setting mode = 2 if you get bad
% results, where you can now step-by-step check what goes wrong. You will
% get a plot showing some letters, and it will step-by-step show you how
% the segmentation worked, and what your classifier classified the letter
% as. Press any button to go to the next letter, and so on.
[hitrate,confmat,allres,alljs,alljfg,allX,allY]=benchmark_inl3(mysystem,datadir,mode);

% Display hitrate
hitrate

%% Results
% Running the script on short1 the hitrate = 1 without errors from matlab

% matlab error on running home1: XXXXXXXXX ?????
% "Subscript indices must either be real positive integers or logicals."
% Then I take off 2 of the 9 features where I get this error and then it
% works and I could run the script and I get hitrate = 0.0960
