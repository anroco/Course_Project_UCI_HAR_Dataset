# Course_Project_UCI_HAR_Dataset

## Installation
* Download the script `run_analysis.R`.
* Source the script `run_analysis.R` in R.

## Script works
The run_analysis.R script performs the following steps:

* Create variables with names of the files to use;
* Download file zip if it does not exist;
* #load data from files X_train, X_test, y_train, y_test, features, activity_labels, subject_train and subject_test;
* Combined XTrainDataset and XTestDataset in one dataset, YTrainDataset and YTestDataset in other and STrainDataset and STestDataset in other;
* Getting the columns from mean and standard deviation of each measurement;
* Assigning activity names to name the activities into YCombined dataset;
* Assigning descriptive variable names to XCombined and YCombined datasets;
* Combined SCombined, YCombined, XCombined datasets into tidyDataset dataset;
* Get tidyDatasetAVG dataset with the average of each variable grouping by activity and subject;
* tidyDatasetAVG is saved as "./UCI_HAR_Tidy_Dataset_AVG.txt", This file contains 181 rows (first row of names) and 68 columns. The first and second column contains subject IDs (30 subjects) and activity names (6 types of activities), in the columns 3 to 68 are the averages for each measurement;

## Codebook
Information about the datasets is provided in `CodeBook.md`.    