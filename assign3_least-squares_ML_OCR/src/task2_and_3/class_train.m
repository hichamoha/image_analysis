                    
                    % class_train() function - Task 2
                    % Image Analysis - Handin 3


function classification_data = class_train(X, Y)
% IMPLEMENT TRAINING OF YOUR CHOSEN MACHINE LEARNING MODEL HERE
%classification_data = 0; % REMOVE AND REPLACE WITH YOUR CODE

%{
Here classification_data is a variable that contains whatever information 
we have extracted during training and is needed during testing. 
NOTE: In our classifier, i.e. for the nearest neighbour method, there is 
no actual training phase; instead, the training data is simply stored in
classification_data.
 %}
[m,n] = size(X);
for i = 1:n
   % preprocessing 
   X(:,i) = normalize(X(:,i)); 
end

% store the training data in classification_data
classification_data = cell(1,2);
classification_data{1} = X;
classification_data{2} = Y;


end

