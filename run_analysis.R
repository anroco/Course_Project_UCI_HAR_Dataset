#Creating variables with names of the files to use
zipFileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "getdata_projectfiles_UCI_HAR_Dataset.zip"
featuresFile <- "UCI HAR Dataset/features.txt"
actLabelsFile <- "UCI HAR Dataset/activity_labels.txt"
XTrainFile <- "UCI HAR Dataset/train/X_train.txt"
XTestFile <- "UCI HAR Dataset/test/X_test.txt"
YTrainFile <- "UCI HAR Dataset/train/y_train.txt"
YTestFile <- "UCI HAR Dataset/test/y_test.txt"
STrainFile <- "UCI HAR Dataset/train/subject_train.txt"
STestFile <- "UCI HAR Dataset/test/subject_test.txt"

#download file zip if it does not exist
if (file.exists(zipFile) == FALSE) {
    download.file(zipFileURL, zipFile, method="wget")
}

#load data from files X_train, X_test, y_train, y_test, features, 
#activity_labels, subject_train, subject_test
XTrainDataset <- read.table(unz(zipFile, XTrainFile), 
                            colClasses = rep("numeric",561))
XTestDataset <- read.table(unz(zipFile, XTestFile), 
                           colClasses = rep("numeric",561))
YTrainDataset <- read.table(unz(zipFile, YTrainFile))
YTestDataset <- read.table(unz(zipFile, YTestFile))
STrainDataset <- read.table(unz(zipFile, STrainFile), col.names = c("subject"))
STestDataset <- read.table(unz(zipFile, STestFile), col.names = c("subject"))
featuresDataset <- read.table(unz(zipFile, featuresFile), 
                              colClasses = c("numeric", "character"),
                              col.names = c("id_feature", "name_feature"))
actLabelsDataset <- read.table(unz(zipFile, actLabelsFile), 
                              colClasses = c("numeric", "character"))

#combined XTrainDataset and XTestDataset in one dataset
XCombined <- rbind(XTrainDataset, XTestDataset)

#combined YTrainDataset and YTestDataset in one dataset
YCombined <- rbind(YTrainDataset, YTestDataset)

#combined STrainDataset and STestDataset in one dataset
SCombined <- rbind(STrainDataset, STestDataset)

#getting the columns from mean and standard deviation of each measurement.
indexFeatures <- grep("-mean\\(\\)|-std\\(\\)", featuresDataset$name_feature)
XCombined <- XCombined[, indexFeatures]

#assigning activity names to name the activities in the dataset
YCombined[, 1] = actLabelsDataset[YCombined[, 1], 2]

#assigning descriptive variable names to dataset
names(XCombined) <- featuresDataset[indexFeatures, 2]
names(YCombined) <- c("activity")

#getting tidy dataset.
tidyDataset <- cbind(SCombined, YCombined, XCombined)

#getting a dataset with the average of each variable grouping 
#by activity and subject.
colNum <- dim(tidyDataset)[2]
m <- tidyDataset[, 3:colNum]
tidyDatasetAVG <- aggregate(m, list(tidyDataset$subject, tidyDataset$activity),
                            mean)
names(tidyDatasetAVG)[1] <- "subject"
names(tidyDatasetAVG)[2] <- "activity"

#creating file.
write.table(tidyDatasetAVG, "UCI_HAR_Tidy_Dataset_AVG.txt", row.name=FALSE)