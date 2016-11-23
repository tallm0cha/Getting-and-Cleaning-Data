library(dplyr)
library(tidyr)

#Define paths
path <- getwd()
path <- paste(path,"/UCI HAR Dataset/",sep="")
pathTest <- paste(path,"/test/",sep="")
pathTrain <- paste(path,"/train/",sep="")

#Load files
## Test files
xtest <- read.table(paste(pathTest,"/X_test.txt",sep=""),header=F)
ytest <- read.table(paste(pathTest,"/y_test.txt",sep=""),header=F)
subtest <- read.table(paste(pathTest,"/subject_test.txt",sep=""),header=F)
## Train files
xtrain <- read.table(paste(pathTrain,"/X_train.txt",sep=""),header=F)
ytrain <- read.table(paste(pathTrain,"/y_train.txt",sep=""),header=F)
subtrain <- read.table(paste(pathTrain,"/subject_train.txt",sep=""),header=F)
## Features and Activity
features <- read.table(paste(path,"features.txt",sep=""),header=F)
activity <- read.table(paste(path,"activity_labels.txt",sep=""),header=F)
colnames(activity) <- c("Activity.ID","Activity.Label")

#Merge files
testMerged_suby <- cbind.data.frame(subtest, ytest)
testMerged <- cbind.data.frame(testMerged_suby, xtest)
trainMerged_suby <- cbind.data.frame(subtrain, ytrain)
trainMerged <- cbind.data.frame(trainMerged_suby, xtrain)

mergedData <- rbind.data.frame(testMerged,trainMerged)

#Add column names
featCols <- as.character(features$V2)
colNames <- c("Subject","Activity ID",featCols)
vColNames <- make.names(colNames, unique=TRUE, allow_ = TRUE)
vColNames<-gsub('\\.','',vColNames)
colnames(mergedData) <- vColNames

#Extract Mean and Std Dev
meansStddev<-select(mergedData, Subject,ActivityID,contains("mean"), contains("std"),-contains("angle"))

#Add Activity labels
Step4Data<-merge(activity,meansStddev, by.x="Activity.ID", by.y="ActivityID")
Step4Data<-select(Step4Data,-Activity.ID)

#Generate averages
Step5Data <- Step4Data %>% 
  group_by(Activity.Label,Subject) %>%
  summarize_each(funs(mean(., na.rm=TRUE)))

#Write final table
write.table(Step5Data,file="Final Tidy Dataset.txt", row.names = F)
