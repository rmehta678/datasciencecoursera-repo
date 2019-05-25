CodeBook UCI HAR Dataset

## Introduction: 
The procurement of this raw data is described in detail within the “UCI HAR Dataset” folder with the ReadMe.txt file. To clean this data however one needs to run the “run_analysis.R” script located within the very same folder. The steps taken to summarize and aggregate the data will be described below. 

## Reading the Data 
You must ensure your working directory is at the top level of this repository, just one level above the “UCI HAR Dataset” folder.

DataSets Read:
* X_test: Values of all feature variables for the test set
* X_train: Values of all feature variables for the training set
* y_test: Identifies the activity (Walking,Walking Upstairs, Walking Downstairs, Sitting, Standing or Laying) for the test set
* y_train: Identifies the activity (Walking,Walking Upstairs, Walking Downstairs, Sitting, Standing or Laying) for the training set
* activity_labels: Labels in categorical variable form corresponding to y_test and y_train numbers
* features: Description of all the observations recorded in the X_train/X_test set

## Merging X_test/X_train DataSets While Extracting mean()/std() and Labelling

Variables: merged_Training_Test_Data, desiredSummaryStatistics, features, X_train, X_test

1. Concatenated the rows of the X_test and X_train datasets to create one large data set
2. Extracted all instances of mean()/std() from the features dataset and subset the large dataset with only the desired feature observations
3. Used the features dataset to name the columns of the large dataset

## Introducing the Activity and Labelling

Variables: merged_Training_Test_Data, activity_Merged, activity_Names, activity_Labels

1. Concatenated the y_train/y_test rows in the same order as X_test/X_train were concatenated prior to appending them as the first column into the large dataset
2. Factorized the y columns to apply activity labels to them and rename the column to “Activity” 

## Introducing the Subject and Labelling

Variables: merged_Training_Test_Data, subject_Merged

1. Concatenated the subject_train/subject_test rows before appending them as the first column into the large dataset
2. Labelled the column as “Subject” 

## Creating an Independent Tidy Dataset

Variables: meltedData, independentTidySet, merged_Training_Test_data

Goal is to calculate the average of each feature variable for each activity and subject
1. Melted the large dataset keeping the activity and subject
2. Aggregated the data by Subject and Activity calculating the mean of every other column
3. Wrote the new tidy dataset as a text file with comma separations