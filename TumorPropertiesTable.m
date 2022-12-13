clc; clear all; close all;

TrainingImages = imageDatastore('Final Project Images\Training\', 'IncludeSubfolders', true);
TestingImages = imageDatastore('Final Project Images\Testingg\', 'IncludeSubfolders', true);

TrainingData = table('Size' ,[numel(TrainingImages.Files) 4], 'VariableTypes', {'double', 'double', 'double', 'string'}, 'VariableNames', {'Area', 'Density', 'Length', 'Type'});
TestingData = table('Size' ,[numel(TestingImages.Files) 4], 'VariableTypes', {'double', 'double', 'double', 'string'}, 'VariableNames', {'Area', 'Density', 'Length', 'Type'});

Data = 0;
CounterTrain = 1;
while CounterTrain ~= numel(TrainingImages.Files)+1
    CurrentImage = readimage(TrainingImages, CounterTrain);
    [ReducedImage, Di] = TumorRed(CurrentImage, CounterTrain, Data);
    [A, D] = TumorDat(ReducedImage);
    TrainingData{CounterTrain, 1} = A;
    TrainingData{CounterTrain, 2} = D;
    TrainingData{CounterTrain, 3} = Di;
    if CounterTrain <= 20
        TrainingData{CounterTrain, 4} = 'A';
    elseif CounterTrain >= 21 && CounterTrain <= 40
        TrainingData{CounterTrain, 4} = 'M';
    else
        TrainingData{CounterTrain, 4} = 'P';
    end
    CounterTrain = CounterTrain + 1;
end

save('TrainingData.mat', 'TrainingData');


Data = 1;
CounterTest = 1;
while CounterTest ~= numel(TestingImages.Files)+1
    CurrentImage = readimage(TestingImages, CounterTest);
    [ReducedImage, Di] = TumorRed(CurrentImage, CounterTest, Data);
    [A, D] = TumorDat(ReducedImage);
    TestingData{CounterTest, 1} = A;
    TestingData{CounterTest, 2} = D;
    TestingData{CounterTest, 3} = Di;
    if CounterTest <= 20
        TestingData{CounterTest, 4} = 'A';
    elseif CounterTest >= 21 && CounterTest <= 40
        TestingData{CounterTest, 4} = 'M';
    else
        TestingData{CounterTest, 4} = 'P';
    end
    CounterTest = CounterTest + 1;
end
save('TestingData.mat', 'TestingData');