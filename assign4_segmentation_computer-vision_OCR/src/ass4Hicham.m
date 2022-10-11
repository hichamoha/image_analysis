
clc; close all; clear; 
load femfel

% show 2 images at once
imshow([femfel1, femfel2]); % Assumes same number of rows in each.

%%
clc; close all; clear; 
load femfel

% Tracking algorithm and Reconstruction of the video
I = [femfel1, femfel2];
figure; 
%for frame = 1 : numberOfFrames
for image = 1 : size(I)
    
    % Extract frame from the video. 
    %thisFrame = read(videoObject, frame); 
    initial = I(image);
    
    % visualizzation 
    %hImage = subplot(2, 1, 1); 
    %image(thisFrame); 
    %caption = sprintf('Frame %14d of %d.', frame, numberOfFrames); 
    subplot(1,2,1)
    imshow(initial);
    
    %show the number of the actual frame
    %title(caption, 'FontSize', fontSize); 
    
    %drawnow; % Force it to refresh the window. 
    %numberOfFramesWritten = numberOfFramesWritten + 1; 
    
    % Background  
    alpha = 0.5; 
    if image == 1 
        Background = initial; 
    else
        % Change backgroung of each frame 
        Background = (1-alpha)* initial + alpha * Background; 
    end
    
    %background = imdilate(g, ones(1, 1, 5));
    %imtool(Background(:,:,1))
    
    % Difference between image and background. 
    differenceImage = initial - uint8(Background); 
    grayImage = rgb2gray(differenceImage);    % XXXXXXXX
    
    % Convert the grayscale image to binary
    thresholdLevel = graythresh(grayImage); % prendi la soglia. 
    binaryImage = imbinarize( grayImage, thresholdLevel); % binarizzazione 
    
    %% Disturbance elimination
    subplot(2, 1, 2); 
    BW = bwareaopen(binaryImage,20); 
    
    % Plot the trajectory/Binary reconstruction. 
%     imshow(BW); 
    imshow(label2rgb(L, @jet, [.5 .5 .5]))
    title('The Binary Imagine', 'FontSize', fontSize); 
    
end

%% Computer vision
clear, clc, close all;

% Assume that the camera matrices for two projections are
P1 = [3 2 1 0;
      2 2 3 0;
      2 2 2 1 ];
P2 = [ 2 4 3 3;
       1 2 0 2;
       1 1 3 0 ];
% The so called fundamental matrix is then
F = [ 3 -3 -6;
     -6  7  9;
     -4  6  2 ];
% The following three points are detected in image 1:
a1 = [1 2 1 ]'; a2 = [16 10 1 ]'; a3 = [-7 -8 1 ]';
% In image 2 the following three points are detected:
b1 = [1 1 1 ]'; b2 = [3 2 1 ]'; b3 = [-1 -3 1 ]';
%Which points can be in correspondence?
%For the report: Provide your calculations, your answer and your motivation.

% compute the projection of a1, a2, a3 in P1
% a1p = P1 * a1;
% a2p = P1 * a2;
% a3p = P1 * a3;
% compute the projection of b1, b2, b3 in P2
% b1p = P2 * b1;
% b2p = P2 * b2;
% b3p = P2 * b3;

% Any corresponding abar to a should fullfill abar'*F*a = 0
Funda = cell(1,3);
Funda{1} = F * a1;
Funda{2} = F * a2;
Funda{3} = F * a3;
[m,n] = size(Funda);
for i = 1:n
    b1' * Funda{i}
    b2' * Funda{i}
    b3' * Funda{i}
end

% Result: b2 corresponds to a2 and b3 corrsponds to a3
