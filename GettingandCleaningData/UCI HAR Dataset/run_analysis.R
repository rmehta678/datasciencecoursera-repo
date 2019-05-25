##NAME: run_analysis.R
##AUTHOR: Rohan Mehta
##DATE: 05/24/2019

## Reading in the Training/Testing Data/Labels/Features 
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_Train <- read.table("UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_Test <- read.table("UCI HAR Dataset/test/subject_test.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

subject_Merged <- rbind(subject_Train, subject_Test)
activity_Merged <- rbind(y_train, y_test)

## Create and label prototype of tidy-data structure without activity/subjects
merged_Training_Test_Data <- rbind(X_train, X_test)
desiredSummaryStatistics <- grep("std()|mean()", features[,2])
merged_Training_Test_Data <- merged_Training_Test_Data[,desiredSummaryStatistics]
names(merged_Training_Test_Data) <- features[desiredSummaryStatistics,2]

# Create and label previous data struct with activities labelled
merged_Training_Test_Data <- cbind(activity_Merged,merged_Training_Test_Data)
activity_Names <- factor(merged_Training_Test_Data[,1])
levels(activity_Names) <- activity_labels[,2]
merged_Training_Test_Data[,1] <- activity_Names
names(merged_Training_Test_Data)[1] <- 'Activity'

# Create and label previous data struct with subject labelled
merged_Training_Test_Data <- cbind(subject_Merged,merged_Training_Test_Data)
names(merged_Training_Test_Data)[1] <- 'Subject'

# Create an independent tidy data set with average of each feature variable for each activity and subject
meltedData <- melt(merged_Training_Test_Data, (id.vars = c("Activity", "Subject")))
independentTidySet <- dcast(meltedData, Subject + Activity ~ variable, mean)
write.table(independentTidySet, "tidydata.txt", sep = ",",row.names = FALSE)