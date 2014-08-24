## Getting and Cleaning Data Project
##
## Jeff Tomlinsn - August 2014
##
## This script reads the Samsung data for both training and test, 
## add the description of the variables and merges the subject 
## identifiers and activity codes.
## From this data, the variables for mean and standard deviation are
## kept and are averaged for each patient and activity.  
## An output "tidy" file is produced from this, as well as a code
## book describing the variables in the output file.

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
write.table(outtab, "./GandCD_Project.txt", row.names=FALSE)

# Create the codebook.

sink("./codebook.txt")
cat("Code Book for Getting and Cleaning Data Project\n\nFile:GandCD_Project.txt\n\n")

# ... Subject
cat(names(outtab)[1],"\n")
cat("    Type:", class(outtab[,1]),"\n")
cat("    Description: Subject identifier\n")
cat("    Range:",min(outtab$subject),"to",max(outtab$subject),"\n\n")

# ... Activities
cat(names(outtab[2]),"\n")
cat("    Type:", class(outtab[,2])
    ,"as character, with a maximum length of"
    ,max(nchar(as.character(activityLabels[,2]))),"characters\n")
cat("    Description: Activity type\n    Values:\n")
for (j in 1:nrow(activityLabels)){
  cat("        ",as.character(activityLabels[j,2]),"\n")
}
cat("\n")

# ... the numeric variables.
for (i in 3:ncol(outtab)) {
  cat(names(outtab)[i],"\n")
  cat("    Type:", class(outtab[,i]),"\n")
  lns <- strsplit(names(outtab)[i],"-")
  lnst <- lns[[1]][2]
  mors <- gsub("Average ","",lns[[1]][1])
  axis <- lns[[1]][3]
  if (lnst == "mean()") {lnst <- "mean"
  } else if (lnst == "std()") {lnst <- "standard deviation"
  } else {lnst = "????"}
  
  if (is.na(axis)) {
    cat("    Description: Average of the",lnst,"of",mors,"\n")    
  } else {
    cat("    Description: Average of the",lnst,"of",mors,"for the",axis,"axis.\n")
  }
  cat("    Range:",min(outtab[,i]),"to",max(outtab[,i]),"\n\n")
}
sink()


