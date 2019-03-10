## Getting and cleaning data course project
## Author: Diego Alvarez

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
## each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

## Load required packages
library(plyr)

## Download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "dataset.zip")

## Unzip file
if(!file.exists("./Getting_and_Cleaning_Data_Project")) {
        unzip("dataset.zip")
}

## Read training data
featuresTrain    <- read.table("./UCI HAR Dataset/train/X_train.txt")
activityTrain    <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Read test data
featuresTest     <- read.table("./UCI HAR Dataset/test/X_test.txt")
activityTest     <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subjectTest  <- read.table("./UCI HAR Dataset/test/subject_test.txt")

activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
featureNames  <- read.table("./UCI HAR Dataset/features.txt")

## 1. Merge the training and test sets to create one data set

features <- rbind(featuresTrain, featuresTest)
activity <- rbind(activityTrain, activityTest)
subject <- rbind(subjectTrain, subjectTest)

## Set names to variables

colnames(features) <- t(featureNames[2])
colnames(activity) <- "activity"
colnames(subject) <- "subject"

## Coerce data
allData <- cbind(features,activity,subject)


## 2. Extract only the measurements on the mean and standard deviation for each 
## measurement

## Extract the column indices that have either mean or std in them
colMeanStd <- featureNames$V2[grep("mean\\(\\)|std\\(\\)", 
                                               featureNames$V2)]

## Subset the desired columns
requiredColumns <- c(as.character(colMeanStd), "subject", "activity" )
allData <- subset(allData, select=requiredColumns)


## 3. Use descriptive activity names to name the activities in the data set

allData$activity <- activityLabels[allData$activity, 2]


## 4. Appropriately label the data set with descriptive variable names

names(allData) <-gsub("^t", "time", names(allData))
names(allData) <-gsub("^f", "frequency", names(allData))
names(allData) <-gsub("Acc", "Accelerometer", names(allData))
names(allData) <-gsub("Gyro", "Gyroscope", names(allData))
names(allData) <-gsub("Mag", "Magnitude", names(allData))
names(allData) <-gsub("BodyBody", "Body", names(allData))


## 5. From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject


tidyData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(tidyData, "Tidy.txt", row.name=FALSE)



