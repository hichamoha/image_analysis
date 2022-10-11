

% This function is used in Handin 4 to run and test our ocr system in
% version 1 from Assignment 3 and the improved version 2 in Assignment 4.


function classification_data = ocr_class_train2(S,Y)
% classification_data = class_train( X,Y )

%{
Here classification_data is a variable that contains whatever information 
we have extracted during training and is needed during testing. 
NOTE: In our classifier, i.e. for the nearest neighbour method, there is 
no actual training phase; instead, the training data is simply stored in
classification_data.

Matlab file ocrsegments.mat contains a number of segments in a cell array S 
and corresponding letter code y. Again, these are coded from 1 to 26, 
where 1 corresponds to A, 2 corresponds to B and so forth. 
Use your own set of favorite features (recall what you did in Assignment 2), 
to go from segments in S to corresponding feature vectors in a matrix X, 
where each column corresponds to features of a segment in S.
 %}

Ny = size(S,2);
classification_data = cell(1,2);

% Features generation:
% The next step is to take each segment in S and transform it into 
% feature vectors. We use segment2features for this, which is a function
% we implemented in hand-in 2.
S_features = [];
for i = 1:Ny
    S_feat = segment2features2(S{i});
    S_features = [S_features S_feat];
end

% load features and ground truth in the classification data.
classification_data{1} = S_features;
classification_data{2} = Y;
end

