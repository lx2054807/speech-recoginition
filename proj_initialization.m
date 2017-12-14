%{ 
This script is used for:
1. Importing data
2.
    
    
%}

% importing speech samples from .txt file
data_sample = readtable('data_sample.txt'); 

% Choose samples' feature
sample_feature1 = data_sample.feature1;

% Select the range of feature number >= number
range1_sample_feature1 = sample_feature1 >= number 

