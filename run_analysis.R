## Download the data file

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip the data to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Read all the files in the downloaded data
xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table('./data/UCI HAR Dataset/features.txt')
activitylabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Assign columns names to all the tables
colnames(activitylabels)  = c('activityId','activitylabels');
colnames(subjecttrain)  = "subjectId";
colnames(xtrain)        = features[,2]; 
colnames(ytrain)        = "activityId"
colnames(subjecttest) = "subjectId";
colnames(xtest)       = features[,2]; 
colnames(ytest)       = "activityId";

## Merge all the training data files together, then the test data files together, the combine the two merged training and test data
trainingdata = cbind(ytrain,subjecttrain,xtrain);
testdata = cbind(ytest,subjecttest,xtest);
finaldata = rbind(trainingdata,testdata);

## Grab columns names in the final data and identify the columns wanted
colNames <- colnames(finaldata)
meanandstd <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

## Name new data with mean and standard deviation
datawithmeanansstd <- finaldata[ , meanandstd == TRUE]

## Bring in descriptive activity names
datawithactivitynames <- merge(datawithmeanansstd, activitylabels,
                              by='activityId',
                              all.x=TRUE)

## For #5, create a new table, finaldatawithnoat without the activityType column
finaldatawithnoat  = finaldata[,names(finaldata) != 'activityType'];

# Summarize the finaldatanoat have average of each variable for each activity and each subject
tidymeandata    = aggregate(finaldatawithnoat[,names(finaldatawithnoat) != c('activityId','subjectId')],by=list(activityId=finaldatawithnoat$activityId,subjectId = finaldatawithnoat$subjectId),mean);

# Merge the tidymeandata with activitylabels to include descriptive acitvity names
tidymeandata    = merge(tidymeandata,activitylabels,by='activityId',all.x=TRUE);

# Export the tidymeandata set 
write.table(tidymeandata, './tidymeandata.txt',row.names=FALSE,sep='\t')

