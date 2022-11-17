%% Input
Data = imageDatastore('G:\CNN\face PCA48', ...
        'IncludeSubfolders',true,'LabelSource','foldernames')
%% Training sets and test sets
trainingNumFiles = 0.8;
rng(1) % For reproducibility
[trainData,testData] = splitEachLabel(Data, ...
				trainingNumFiles,'randomize'); 
%% Network Architecture
layers = [
    imageInputLayer([36 48 1],"Name","imageinput")
    convolution2dLayer([15 25],52)%32次 90.78
    reluLayer
    averagePooling2dLayer(2,'Stride',2)

    convolution2dLayer([6 7],60)%6 7 60
    reluLayer
    averagePooling2dLayer(2,'Stride',2)
    
    dropoutLayer(0.5)
    fullyConnectedLayer(11,"Name","fc")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
%% Training
options = trainingOptions('sgdm',...
    'MaxEpochs',32,'MiniBatchSize',5,'InitialLearnRate',0.0001, ...
    'Verbose',false,...
    'Plots','training-progress');
net = trainNetwork(trainData,layers,options);
%% Testing
YTest = classify(net,testData);
TTest = testData.Labels;
%accuracy = sum(YTest == TTest)/numel(TTest) 
accuracy = mean(YTest == TTest)