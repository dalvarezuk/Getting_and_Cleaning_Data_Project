# Getting_and_Cleaning_Data_Project


The purpose of this project is to prepare tidy data that can be used for later analysis. 

The project contains: 

1. A tidy data set.

2. A `Readme.md` file.

3. A code book that describes the variables, the data, and any transformations or work performed to clean up the data called `CodeBook.md`. 

4. A R script called `run_analysis.R` as described below.



The data for the project has been collected from the following link:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](http://)

The R script called `run_analysis.R` that does the following:

1. Merges the training and the test sets to create one data set

2. Extracts only the measurements on the mean and standard deviation for each measurement

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names

5. From the data set in step 4, a second independent tidy data set is created with the average of each variable for each activity and each subject