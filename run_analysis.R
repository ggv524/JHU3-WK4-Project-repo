run_analysis <- function() {
#This is JHU3:Week 4 - Class Project   
    
# STEP 001 - Load the libraries we will use for this script: 
    library(data.table)
    library(stats)
    
# STEP 002 - Read the text data files into data frames for further processing
    subjectTRAIN <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
    xTRAIN <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
    yTRAIN <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
    subjectTEST <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
    xTEST <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
    yTEST <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
    
# STEP 003 - Merge the Subject and Y files. For clarity, rename the column headers.
    fullTRAINSubAct <- cbind(subjectTRAIN, yTRAIN)
    fullTESTSubAct <- cbind(subjectTEST, yTEST)
    fullSubAct <- rbind(fullTRAINSubAct, fullTESTSubAct)
    colnames(fullSubAct) <- c("subject", "activity")
    
# STEP 004 - Merge the X files.  For clarity, rename the column headers from the features.txt file
    fullXfile <-rbind(xTRAIN, xTEST)
    fileFeatures <- tbl_df(read.table("./data/UCI HAR Dataset/features.txt"))
    setnames(fileFeatures, names(fileFeatures), c("featNum", "featName"))
    colnames(fullXfile) <- fileFeatures$featName
    
# STEP 005 - Now combine SubAct dataframe and X dataframe into one full dataframe:
    fullData <- cbind(fullSubAct, fullXfile)
    
# STEP 006 - Extract only the measurements on the mean and standard deviation for each measurement.
    desiredCols <- c(1,2,3:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, +
                     255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)
    fullData2 <- subset.data.frame(fullData, select=desiredCols)

# STEP 007 - Add descriptive activity names to name the activities in the data set.
#            Use a translation vector as a lookup table to set the activity names:
    transActivity <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
    names(transActivity) <- c(1, 2, 3, 4, 5, 6)
    fullData2$activity <- transActivity[as.character(fullData2$activity)]

# STEP 008 - Create a tidy data set with the average of each variable for each activity and each subject.
#            Place the created .txt file in the working directory.
    fullData3 <- aggregate(. ~subject + activity, fullData2, mean)
    fullData4 <- fullData3[order(fullData3$subject, fullData3$activity), ]
    write.table(fullData4, file = "./TidyData.txt", row.names = FALSE)

}



