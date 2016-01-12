rm(list=ls(all=TRUE))

#setwd("C:/TInvention/DataScience/ProgrammingAssignment-cd1")
library(dplyr)

#Load all interesting datasets
# features.txt --> column names
# subject_test.txt --> it's a virtual column containing subject id
# y_test.txt --> virtual column containing activity_id, wich decoding is in activity_labels.txt
xtrain <- read.table("UCIHARDataset/train/x_train.txt",header = FALSE)
strain <- read.csv("UCIHARDataset/train/subject_train.txt",header=FALSE)
ytrain <- read.csv("UCIHARDataset/train/y_train.txt",header=FALSE)

xtest <- read.table("UCIHARDataset/test/x_test.txt",header = FALSE)
stest <- read.csv("UCIHARDataset/test/subject_test.txt",header=FALSE)
ytest <- read.csv("UCIHARDataset/test/y_test.txt",header=FALSE)

####1 Merges the training and the test sets to create one data set.
subjects <- c(strain$V1,stest$V1)
activities <- c(ytrain$V1,ytest$V1)
allData <- tbl_df(bind_rows(xtrain,xtest))

#free up memory
rm("strain","stest","ytrain","ytest")
rm("xtest","xtrain")

####2 Extracts only the measurements on the mean and standard deviation for each measurement.

#read the feature list
featureList <- tbl_df(read.csv("UCIHARDataset/features.txt",sep=" ",header = FALSE))
#get indexes with mean & std in title
interestingFL <- filter(featureList,grepl("mean|std",featureList$V2) )
#select interesting data + subj & actv
intData <- select(allData,interestingFL$V1) %>%
    mutate(subject=subjects)  %>%
    mutate(activity=activities)


####3 Uses descriptive activity names to name the activities in the data set
activityLabel <- read.csv("UCIHARDataset/activity_labels.txt",header=FALSE,sep=" ")
intData <- mutate(intData,activity=activityLabel[activity,2])

####4 Appropriately labels the data set with descriptive variable names.
interestingFL <- mutate(interestingFL,V3=tolower(gsub("-|\\(|\\)","",V2)))
names(intData)[1:79] <- interestingFL$V3

####5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

meanData <- intData %>%
    mutate(subject=factor(subject)) %>%
    group_by(activity,subject) %>%
    summarise_each(funs(mean))

#write out data
write.table(meanData,"meanData.txt",row.name=FALSE)
