# BME3503C Final Project README: Team Taco Tuesday

***<p style = "text-align: center;"> <font size="5"> **Defining Astrocytoma, Meningioma, and Pituitary Tumor Location and Type via MATLAB** </font> </p>***

<p>&nbsp;</p>

## Project Description
---
Our project focuses on idenitfying tumor locations by analyzing a data set of images. We use image analysis to 
define tumor locations and boundries. Additionally, the project focuses on tumor identification based on the intrinsic
characteristics of:
* Area
* Maximum Density
* Distance from Image Edges
  
The tumor characteristics are analyzed via machine learning models and classafied as one of the three types from our data set.

<p>&nbsp;</p>

## Setup
---
Our Dataset consists of 120 images and .dat files seperated into the Training and Testing Groups.
Due to how our code is written, there is a sepcifc way the folder needs to be setup in order for the code to run.
This section will cover how to setup the files and functions in order to run the code.

There are five main functions for the project: 
* BrainRed.mlx
  * The function BrainRed.mlx is an optional function to run to extract the MRI scan images form the .dat file and save them
    as individual images. Since we have provided both the original .dat files and image files, it is not necessary to run this program.
    If you do choose to run the file, pleasae place all the .mat files provided in the same folder as the function and run the program.
    ```MATLAB
    CurrentDirectory = uigetdir;
    DirectoryFiles = dir(fullfile(CurrentDirectory,'*.mat'));
    for k = 1:length(DirectoryFiles)
        FileName = DirectoryFiles(k).name;
        FileNameExtension = fullfile(CurrentDirectory, FileName);
        CurrentFile = importdata(FileNameExtension);
        load(FileName);
        tumorImage = cjdata.image;
        ImageConvert = mat2gray(tumorImage);
        imwrite(ImageConvert, [extractBefore(FileName, "."), '_', int2str(cjdata.label), '.png']);
    end
    ```
    To only run the function for determining the cranium borders, comment out the above code section and run the program.

<p>&nbsp;</p>

* TumorRed.m
    * This is one of the main functions of out project. This program will require that the images provided in the dataset is a          subfolder within the folder where the function is stored.
        ```MATLAB
        TrainingImages = imageDatastore('Final Project Images\Training\', 'IncludeSubfolders', true);
        TestingImages = imageDatastore('Final Project Images\Testingg\', 'IncludeSubfolders', true);
        ```
        The program will require no location editing if placed within the folder where the function is stored.
        Additionally, the function will require all 120 .mat files to saved as individual files within the folder where the function in stored. Note that this means the files are stored individually and not as a subfolder within the parent folder.

<p>&nbsp;</p>

* TumorDat.m
    * This is the second primary functions of our project. It will require the same setup as the previous function, with a subfolder of images and all of the .mat files stored in the folder of the function.

<p>&nbsp;</p>

* TumorPropertiesTable.m
    * This is the main program that needs to be run to create the data for the machine learning algorithm. It needs to be stored in the same folder as the functions TumorRed.m and TumorDat.m. It will also require the same folder setup as the functions stated above. 
        ```MATLAB
        TrainingData = table('Size' ,[numel(TrainingImages.Files) 4], 'VariableTypes', {'double', 'double', 'double', 'string'},        'VariableNames', {'Area', 'Density', 'Length', 'Type'});
        TestingData = table('Size' ,[numel(TestingImages.Files) 4], 'VariableTypes', {'double', 'double', 'double', 'string'}, 'VariableNames', {'Area', 'Density', 'Length', 'Type'});
        ```
        This program will also create and save two tables as .mat files titled TrainingData.mat and TestingData.mat. These two files are final output of the program and are required for the machine learning algorithms.

<p>&nbsp;</p>

* LearningModels.mlx
    * This is program that creates two machine learning models and displays the confusion matrix for the model. The program will require the TrainingData.mat and TestingData.mat files to be stored in the same folder as the function. If all the programs are stored in the same folder, the output from the TumorPropertiesTable.m automatically stores the tables in the same folder, and will require no chnages.
    * Two additional machine learning models were analyzed using the Classification Learner App in MATLAB, and were not run via the code in the program. Their relavent outputs are included as figures in our dataset, and will not require the running of the App. Our program outputs all of the figures.
        ```MATLAB
        CM = openfig("Model2Confusion.fig");
        shg
        CL = openfig("Model4Confusion.fig");
        shg
        ```
        The code above is an example of two figures displayed in the program. This will require all the figures to be stored individually in the same folder as the program.

<p>&nbsp;</p>

We also have provided three files: FunctionPresentationBrainRed.mlx, FunctionPresentationTumorRed.mlx, and FunctionPresentationTumorDat.mlx. These are functions we used in our presentation with an example image to demostrate the functionality of our code. The files are for demonstration purposes only and not meant to be run.

<!-- <p style="align" # How to Run -->
<p>&nbsp;</p>

## How to Run
---
After modeling the folder based on the descriptions provided in the Setup section, the project will require the TumorPropertiesTable.m and the LearningModels.mlx files to run in order to generate an output. First, run the TumorPropertiesTable.m file to generate the table data for the machine learning models. After it is done running, check and ensure that TrainingData.mat, TestingData.mat, and the figures from the other machine learning models are stored in the same folder as LearningModels.mlx.

Next, run LearningModels.mlx to train and display the results of the four machine learning models, two of which are figures from the Classification Learner App that will displayed.

<p>&nbsp;</p>

## Documentation and Results
---
Please see ____<!-- [FinalProjectReport](https://) --> <!-- Add a link for the final report Google Doc in the previous comment --> for in-depth explanation of results. For any additional help, [Contact us](mailto:ramachandranv@ufl.edu).