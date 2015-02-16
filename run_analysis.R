#unzip the datafile in your working directory

#create backup/store directory
if(!file.exists("./data")){dir.create("./data")}

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

#set descriptive variable names
names(X_train) <- labels$V2
names(y_train) <- c("activity")
names(subject_train) <- c("subject_ID")

names(X_test) <- labels$V2
names(y_test) <- c("activity")
names(subject_test) <- c("subject_ID")

#coerce data to one set
trainData <- cbind(subject_train, y_train, X_train)
testData <- cbind(subject_test, y_test, X_test)

#set descriptive names for activities
trainData$activity <- factor(trainData$activity, labels=activity_labels$V2)
testData$activity <- factor(testData$activity, labels=activity_labels$V2)

#add group column to identify test vs train group
trainData$group <- c("train")
testData$group <- c("test")

tidyData <- rbind(testData,trainData)

#create backup
write.csv(tidyData,"./data/tidyData.csv", row.names=FALSE)

#subset on mean and std


#data set with the average of each variable for each activity and each subject









