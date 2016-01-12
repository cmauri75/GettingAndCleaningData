# CodeBook

## Datasource

* Original data: [origin_data]
* Original description: [origin_desc]

## Data Set Information

The experiments have been carried out by 30 volunteers wearing a smartphone that recorded their movement during 6 different type of activity.

Data are stored in UCIHARDataset directory.

The dataset includes the following files:

- 'activity_labels.txt': the descriptions of the labels code.
- 'features.txt': All features.
- 'features_info.txt': Description of variables used on the feature vector.
- 'README.txt'

Data used are:

- 'train/*: train data
- 'test/*: test data

Both type of data where merged together in a comprehensive data

## Transformation details

1. Extracts only the measurements on the mean and standard deviation for each measurement from both train and test data sets
2. Uses descriptive activity names to name the activities in each data set(train and test)
3. Appropriately labels the data set with descriptive activity names.
4. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
5. Merges the training and the test sets to create one data set.


## How ```run_analysis.R``` implements the above requirements:

* Require ```dplyr``` librareis.
* download the git repo
* run the run_analysis.R
* meanData.txt file will be created

[origin_data]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
[origin_desc]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
