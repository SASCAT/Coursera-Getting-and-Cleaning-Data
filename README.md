GandCD_Project
==============

Project for the Getting and Cleaning Data course

Objectives 
==========
You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Operation
---------

The analysis script is **run_analysis.R**.  
the script reads the *Samsung* data files and produces a tidy dataset of the means and standard deviations from the *Samsung* data, an output file with average values of the tidy dataset as well as a code book for the data in the tidy dataset.

The analysis script requires that the Samsung data is in the working directory for the script.  
The required files are:
* features.txt
* X_test.txt
* subject_test.txt
* y_test.txt
* X_train.txt
* subject_train.txt
* y_train.txt
* activity_labels.txt








