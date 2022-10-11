                % Handin 3 - Task 4
                % fucnction features2class(x,classification_data)
%{
Now, using machine learning we construct a classifier that takes a feature 
vector x and calculates a class y. 
The function takes a feature vector x as input and returns a 
number y as output. Here y is an integer between 1 and 26. 
The characters are coded from 1 to 26, where 1 corresponds to A, 
2 corresponds to B and so forth.
%}
function y = myFeatures2class(x,classification_data)

% Here we can choose K to K-NN algorithm
K = 1;
% the stored training data which come from class_train function
feats_train = classification_data{1};
Y_train = classification_data{2};
N = size(feats_train,2);

% initialize a list for the distances to all training data points
D = zeros(1,N);

for i = 1:N
    % calculate the Euclidean distance and store it in the list
    D(i) = norm(feats_train(:,i) - x);
end

% initialize a voting vector
votes = zeros(1,K);

% voting loop
for i = 1:K
   % get the index of the least distance 
   minimum = min(D);
   index = min(find(D == minimum));
   
   % assign the class of the K nearest neighbors
   votes(i) = Y_train(index);
   D(index) = Inf; % IEEE arithmetic representation for positive infinity
end

% Assign a class based on the majority of classes present in the chosen
% points, now we have only one element because K = 1
% mode() get the most frequently occurring value in votes
y = mode(votes);

end
