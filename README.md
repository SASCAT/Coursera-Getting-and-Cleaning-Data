# GandCD_Project

Project for the Getting and Cleaning Data course

## Objectives 
You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Additionally create a code book describing the variables for the tidy variables in the tidy dataset. 

## Operation Overview
The analysis script is **run_analysis.R**.  
The script reads the *Samsung* data files and produces a tidy dataset of the means and standard deviations from the *Samsung* data by subject and activity (*GandCD_Project.txt*). It also produces a code book for tidy dataset (*codebook.txt*).

## Operation details.
1. Read in *features.txt* with the names of the 561 feature variables in the test and training data files.
2. For the test data, read in the test data from *X_test.txt* and merge in the subject identifiers from *subject_test.txt* and the activity codes from *y_test.txt*
3. For the training data, read in the training data from *X_train.txt* and merge in the subject identifiers from *subject_train.txt* and the activity codes from *y_train.txt*
4. Append the training to the test data frame.
5. Apply the names from *features.txt* to the data in the combined data.
6. Replace the activity codes with their full names.  The names are defined in *activity_labels.txt*
7. Select the ID columns for the subjects and activities and the data columns for mean and standard deviation.  The mean columns are identified by having names containing "mean()" and the standard deviation columns are identified by having names containing "std()"
8. Calculate the mean values for the data for each subject and activity. this will be the data frame used for the final tidy dataset.
9. Output the tidy data to *GandCD_Project.txt*
10. Create a code book called *codebook.txt* for the data in *GandCD_Project.txt* 


### Inputs
The analysis script requires that the Samsung data is in the working directory for the script.  
The required input files are:
* features.txt
* X_test.txt
* subject_test.txt
* y_test.txt
* X_train.txt
* subject_train.txt
* y_train.txt
* activity_labels.txt

### Outputs
The output generated is 
* Output tidy dataset as text file *GandCD_Project.txt* containing the averages of the mean and standard deviation data by subject and activity
* Code book of the variables in output tidy dataset called *codebook.txt*


