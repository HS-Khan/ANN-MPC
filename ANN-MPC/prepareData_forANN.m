%%# This script calls all acquired data by MPC and combines them into the proper form 
% for performing the training of the neural network, considering "Linear and Non-Linear" loads.

clc; close all; clear;

Input_8_Features = 1;               % A logical parameter to choose/call the input features with a lenght of 9.
Input_8_Features_withOneDelay = 0;  % A logical parameter to choose/call the input features with a lenght of 17.
Input_8_Features_with2Delays = 0;   % A logical parameter to choose/call the input features with a lenght of 25.
LinearLoad = 0;

%% Load the Data Files.
if LinearLoad == 0
    % Case #1: Linear Loads  
    Samples = 60;
else
    % Case #2: Non-Linear Loads 
    Samples = 70;
end
% To store the dataset
InputFeaturesSamples = cell(1, Samples);
TargetsSamples = cell(1, Samples);

% Choose the kind of datatset for training the proposed neural network.
for i = 1:Samples
    % Calling the input vector with 9 features (including Ts intervals) and their corresponding targets.    
    if Input_8_Features
        myfilename = sprintf('Dataset/InputFeatures/Input_8Features/Sample%d.mat', i);
        myfilename1 = sprintf('Dataset/InputFeatures/Targets/Targets-8inputs/TargetSample%d.mat', i);
    % Calling the input vector with 17 features (including one-step delay of the eight features, and also Ts intervals)
    % and their corresponding targets.    
    elseif Input_8_Features_withOneDelay
        myfilename = sprintf('Dataset/InputFeatures/Input_8FeaturesWithDelay/OneDelaySamples/Sample%d.mat', i);
        myfilename1 = sprintf('Dataset/InputFeatures/Targets/TargetSample%d.mat', i);
    % Calling the input vector with 25 features (including two-steps delay of the eight features, and also Ts intervals)
    % and their corresponding targets.   
    elseif Input_8_Features_with2Delays
        myfilename = sprintf('Dataset/InputFeatures/Input_8FeaturesWithDelay/TwoDelaysSamples/Sample%d.mat', i);
        myfilename1 = sprintf('Dataset/InputFeatures/Targets/TargetSample%d.mat', i);
    end
    InputFeaturesSamples{i} = importdata(myfilename);  
    TargetsSamples{i} = importdata(myfilename1);
end

% From cell to matrix conversion, the proper form for NN training.
T = cell2mat(TargetsSamples);
X = cell2mat(InputFeaturesSamples);
% neglect the last row, which contains the sampling time (i.e., Ts) intervals.
X = X((1:size(X,1)-1),:); 
% nnstart

