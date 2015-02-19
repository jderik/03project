## Getting and Cleaning data Course Project

###  File details  #########################
 'train/X_train.txt': Training set.
 
 'train/y_train.txt': Training labels.
 
 'test/X_test.txt': Test set.
 
 'test/y_test.txt': Test labels.
 
 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
 
 'test/Subject_test.txt' : Subject test data

 'features_info.txt': Shows information about the variables used on the feature vector.

 'features.txt': List of all features.

 'activity_labels.txt': Links the class labels with their activity name.

###  Read test and training data
XTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)

YTrain <- read.table ("UCI HAR Dataset/train/Y_train.txt", header=FALSE)

SUBTrain <-read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)

SUBTest <-read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)

XTest  <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)

YTest  <- read.table("UCI HAR Dataset/test/Y_test.txt", header=FALSE)


###  Merge the data of these three sets##################

dataSUB <- rbind(SUBTrain, SUBTest)

dataY<- rbind(YTrain,YTest)

dataX<- rbind(XTrain,XTest)


###  Naming the data sets activities with descriptive activity names

names(dataSUB)<-c("Subject")

names(dataY)<- c("Activity")

dataXnames <- read.table("UCI HAR Dataset/features.txt",head=FALSE)

names(dataX)<- dataXnames$V2

### Create one merged data set by combining the individual data frames.

dataset01 <- cbind(dataSUB, dataY)

datasetfinal <- cbind(dataX, dataset01)

At this point the names(datasetfinal) looks like below (some random samples)
[33] "tBodyAcc-arCoeff()-Y,4"  ;  [64] "tGravityAcc-entropy()-Y" ; [69] "tGravityAcc-arCoeff()-X,4" ; [172] "tBodyGyroJerk-max()-Z" ; [553] "fBodyBodyGyroJerkMag-skewness()"

### Apply descriptive activity Labels to the variable names as evidenced above.

names(datasetfinal)<-gsub("^t", "time", names(datasetfinal))

names(datasetfinal)<-gsub("^f", "frequency", names(datasetfinal))

names(datasetfinal)<-gsub("Acc", "Accelerometer", names(datasetfinal))

names(datasetfinal)<-gsub("Gyro", "Gyroscope", names(datasetfinal))

names(datasetfinal)<-gsub("Mag", "Magnitude", names(datasetfinal))

names(datasetfinal)<-gsub("BodyBody", "Body", names(datasetfinal))

### Tidy data Set generation usig PLYR
#### Load plyr 
library(plyr)

datasetaverage <- ddply(datasetfinal, .(Subject, Activity), function(x) colMeans(x[, 1:66]))
#### Create Tidy Data Set called datasetaverage.txt ; This is uploaded to repository 
write.table(datasetaverage, "datasetaverage.txt", row.name=FALSE)
