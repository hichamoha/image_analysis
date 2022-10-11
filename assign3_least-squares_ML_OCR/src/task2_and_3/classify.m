
             % classify() function - Task 2
             % Image Analysis - Handin 3
             

function y = classify(x, classification_data)
% IMPLEMENT YOUR CHOSEN MACHINE LEARNING CLASSIFIER HERE
%y = 0; % REMOVE AND REPLACE WITH YOUR CODE

% Using the K-Nearest Neighbours algorithm

% K represents the number of training data points lying in proximity to the
% test data point which we are going to use to find the class.
% choose the value of k
K = 5;

isFace = 0;
nonFace = 0;

% 0. preprocessing of data set
x = normalize(x);

% 1. Loading the training and test data\
X = classification_data{1};
Y = classification_data{2};

[m1,n1] = size(X); 
[m2,n2] = size(Y); 

faces = [];
nonfaces = [];

% 3. For each point in test data:
for i = 1:n1
   % distance measurement to all training data points
   d = norm(X(:,i) - x);
   
   % store the distances in a list
   if Y(i) == 1
       faces = [faces d];
   else
       nonfaces = [nonfaces d];
   end
       
   
end

% sort the Euclidean distances
faces = sort(faces);
nonfaces = sort(nonfaces);

i = 1;
% choose the first k points
while i < K
    if faces(1) <= nonfaces(1)
        isFace = isFace + 1;
        faces = faces(2:end);
        
    elseif nonfaces(1) < faces(1)
        nonFace = nonFace + 1;
        nonfaces = nonfaces(2:end);
    end
    i = i + 1;
end

% assign a class to the test point based on the majority of classes present
% in the chosen points
if isFace > nonFace
    y = 1;
else 
    y = -1;
end

end

