# Step 1
# Merges the training and the test sets to create one data set.

# Read in the labels/names for the variables...
varName <- read.table("./features.txt")
names(varName)[2] <- "label"
varName$name <- varName$label

# ... and step 4
testData <- read.table("./X_test.txt")
names(testData) <- varName$name
testSubj <- read.table("./subject_test.txt")
testY <- read.table("./y_test.txt")
test <- cbind(testSubj, testY, testData)
remove(testData, testSubj, testY)

trainData <- read.table("./X_train.txt")
names(trainData) <- varName$name
trainSubj <- read.table("./subject_train.txt")
trainY <- read.table("./y_train.txt")
train <- cbind(trainSubj, trainY, trainData)

# Combine the test and training data
baseData <- rbind(test,train)
names(baseData)[1:2] <- c("subject", "nact")

# Step 2
# Extracts only the measurements on the mean and standard 
# deviation for each measurement. 

# Which fields are mean and std?
selCols <- grep("mean\\(|std\\(", varName$label)
selCols <- c(1,2,selCols+2)

# Just the mean and std columns
meanstd <- baseData[,selCols]

# Step 3
# Uses descriptive activity names to name the activities in the data set

# read in the names of the activities
activityLabels <- read.table("./activity_labels.txt",header=FALSE)
names(activityLabels) <- c("nact","activity")

# Add the activity labels and restructure so that the subject and 
# the character activity are in the first 2 columns
meanstd <- merge(meanstd, activityLabels, by.x="nact", by.y="nact")
meanstd <- cbind(meanstd$subject, meanstd$activity,meanstd[,3:(ncol(meanstd)-1)])
names(meanstd)[1:2] <- c("subject", "activity")

# Order by subject and activity
meanstd <- meanstd[order(meanstd$subject, meanstd$activity),]

# Step 5
# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject. 

# Calculate the average for all of the variables, by subject and actovity
outtab <- aggregate(meanstd, by=list(meanstd$subject, meanstd$activity), FUN=mean)

# Step 4?
# Appropriately labels the data set with descriptive variable names. 
outtab["subject"] <- NULL
outtab["activity"] <- NULL
names(outtab) <- paste("Average", names(outtab), sep=" ")
names(outtab)[1:2] <- c("subject", "activity")

# Output the averages 
write.table(outtab, "./outtab.txt", row.names=FALSE)
