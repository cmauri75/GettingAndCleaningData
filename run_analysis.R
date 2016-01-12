rm(list=ls(all=TRUE))

setwd("C:/TInvention/DataScience/ProgrammingAssignment-cd1")
library(dplyr)

#Carico tutti i dataset e li mergio, sono width delimited di larghezza 16
#la descrizione delle colonne la trovo in features.txt
# ho inoltre due colonne aggiuntive fittizie, il soggetto (subject_test.txt)
# e il tipo di osservazione (y_test.txt), la cui decodifica sta in activity_labels.txt
xtrain <- read.table("UCIHARDataset/train/x_train.txt",header = FALSE)
strain <- read.csv("UCIHARDataset/train/subject_train.txt",header=FALSE)
ytrain <- read.csv("UCIHARDataset/train/y_train.txt",header=FALSE)

xtest <- read.table("UCIHARDataset/test/x_test.txt",header = FALSE)
stest <- read.csv("UCIHARDataset/test/subject_test.txt",header=FALSE)
ytest <- read.csv("UCIHARDataset/test/y_test.txt",header=FALSE)

subjects <- c(strain$V1,stest$V1)
activities <- c(ytrain$V1,ytest$V1)
rm("strain","stest","ytrain","ytest")

####1 Merges the training and the test sets to create one data set.
allData <- tbl_df(bind_rows(xtrain,xtest))
#free up memory
rm("xtest","xtrain")

####2 Extracts only the measurements on the mean and standard deviation for each measurement.

#read the feature list
featureList <- tbl_df(read.csv("UCIHARDataset/features.txt",sep=" ",header = FALSE))
#get indexes with mean & std in title + subject&activity
interestingFL <- filter(featureList,grepl("mean|std",featureList$V2) )
#select interesting data
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

write.table(meanData,"meanData.txt",row.name=FALSE)

#write.csv2(intData,file = "intData.csv")
#write.csv2(meanData,file = "meanData.csv")
