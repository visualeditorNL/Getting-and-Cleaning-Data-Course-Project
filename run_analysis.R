#unzip the datafile in your working directory and the dplyr and tidyr package are needed for this script
#download here: https://github.com/hadley/dplyr and here: https://github.com/hadley/tidyr if you don't have them

#create backup/store directory
if(!file.exists("./data")){dir.create("./data")}

#load libraries
library(dplyr)
library(tidyr)

#read needed data files
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")

#read label files
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)
labels <- read.table("./UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
#remove punctuation from labels
labels <- gsub("[[:punct:]]", "", labels$V2)

#set descriptive variable names
names(X_train) <- labels
names(y_train) <- c("activity")
names(subject_train) <- c("subject_ID")

names(X_test) <- labels
names(y_test) <- c("activity")
names(subject_test) <- c("subject_ID")

#coerce data to one set
trainData <- cbind(subject_train, y_train, X_train)
testData <- cbind(subject_test, y_test, X_test)

#set descriptive names for activities
trainData$activity <- factor(trainData$activity, labels=activity_labels$V2)
testData$activity <- factor(testData$activity, labels=activity_labels$V2)

#add group column to identify test vs train group
trainData$group <- factor(c("train"))
testData$group <- factor(c("test"))

#merge test and train data together
data <- rbind(testData,trainData)

#subset on mean and std
subset <- select(data,subject_ID,activity, group,contains("mean"),contains("std")) 

#create backup
write.table(subset,"./data/Data_Step4.txt", row.names=FALSE)

#data set with the average of each variable for each activity and each subject
grouped <- group_by(subset,subject_ID,activity) 
final <- summarise_each(grouped, funs(mean),-group)

#create backup
write.table(final,"./data/tidyData_step5.txt", row.names=FALSE)








