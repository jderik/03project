### Course Project - Getting and Cleaning Data.


#############################################################
#######  Read test and trainng data #########################
# 'train/X_train.txt': Training set.
# 'train/y_train.txt': Training labels.
# 'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.
# 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

XTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
YTrain <- read.table ("UCI HAR Dataset/train/Y_train.txt", header=FALSE)
SUBTrain <-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
SUBTest <-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
XTest  <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
YTest  <- read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)


#############################################################
#######  Merge the data of these three sets##################

dataSUB <- rbind(SUBTrain, SUBTest)
dataY<- rbind(YTrain,YTest)
dataX<- rbind(XTrain,XTest)

#############################################################
####################  Naming as per #########################
####https://class.coursera.org/getdata-011/forum/thread?thread_id=181####################
###### Use Descriptive activity names for the activity#######

names(dataSUB)<-c("Subject")
names(dataY)<- c("Activity")
dataXnames <- read.table("UCI HAR Dataset/features.txt",head=FALSE)
names(dataX)<- dataXnames$V2

#############################################################
################  A big final data set ######################

dataset01 <- cbind(dataSUB, dataY)
datasetfinal <- cbind(dataX, dataset01)

## at this point names(datasetfinal) will show the weird variable names and are corrected
## in the next section by replacing abbreviated forms to full names.

#############################################################
########## Label data set with descriptive names ############

names(datasetfinal)<-gsub("^t", "time", names(datasetfinal))
names(datasetfinal)<-gsub("^f", "frequency", names(datasetfinal))
names(datasetfinal)<-gsub("Acc", "Accelerometer", names(datasetfinal))
names(datasetfinal)<-gsub("Gyro", "Gyroscope", names(datasetfinal))
names(datasetfinal)<-gsub("Mag", "Magnitude", names(datasetfinal))
names(datasetfinal)<-gsub("BodyBody", "Body", names(datasetfinal))

#############################################################
################## Tidy data Set generation usig PLYR########
################## Load plyr ################################
library(plyr)
datasetaverage <- ddply(datasetfinal, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
write.table(datasetaverage, "datasetaverage.txt", row.name=FALSE)


