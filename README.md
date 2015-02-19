## Getting and Cleaning data Course Project

###Initialise   variables & WD 
setwd("./UCI HAR Dataset")

###  File details  #########################
 'train/X_train.txt': Training set.
 
 'train/y_train.txt': Training labels.
 
 'test/X_test.txt': Test set.
 
 'test/y_test.txt': Test labels.
 
 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
###  Read test and training data
X-Train <- read.table("train/X_train.txt", header=FALSE)

Y-Train <- read.table ("train/Y_train.txt", header=FALSE)

SUB-Train <-read.table("train/subject_train.txt", header=FALSE)

SUB-Test <-read.table("test/subject_test.txt", header=FALSE)

X-Test  <- read.table("test/X_test.txt", header=FALSE)

Y-Test  <- read.table("test/Y_test.txt", header=FALSE)


####  Merge the data of these three sets##################

dataSUB <- rbind(SUB-Train, SUB_Test)

dataY<- rbind(Y-Train,Y-Test)

dataX<- rbind(X-Train,X-Test)


###  Naming the data sets as per https://class.coursera.org/getdata-011/forum/thread?thread_id=181 

names(dataSUB)<-c("Subject")

names(dataY)<- c("Activity")

dataXnames <- read.table("features.txt",head=FALSE)

names(dataX)<- dataXnames$V2

### Create one merged data set by combining the individual data frames.

dataset01 <- cbind(dataSUB, dataY)

datasetfinal <- cbind(dataX, dataset01)

