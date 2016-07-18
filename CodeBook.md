
##TITLE:	CodeBook.md
##COMMENT:  This is the Code Book for JHU3:Week4 - Getting and Cleaning Data - Course Project
 
The data analyzed in this project is a collection of motion statistics gathered from Samsung Galaxy S II smartphones.  Activity data was captured from 30 voulenteers with ages between 19 to 48 years.   A series of six activities were monitored while each individual wore a smartphone on the waist.  These activities were:
	1. WALKING
	2. WALKING_UPSTAIRS
	3. WALKING_DOWNSTAIRS
	4. SITTING
	5. STANDING
	6. LAYING
By using the embedded accelerometer and gyroscope in each phone, the study authors captured 3-axial linear acceleration and 3 axial angular velocity at a constant rate of 50Hz.  They video-recorded the experiments to label the data manually. The resulting dataset of observations has been made available for our use in this project.

### VARIABLES:
These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    -tBodyAcc-XYZ
    -tGravityAcc-XYZ
    -tBodyAccJerk-XYZ
    -tBodyGyro-XYZ
    -tBodyGyroJerk-XYZ
    -tBodyAccMag
    -tGravityAccMag
    -tBodyAccJerkMag
    -tBodyGyroMag
    -tBodyGyroJerkMag
    -fBodyAcc-XYZ
    -fBodyAccJerk-XYZ
    -fBodyGyro-XYZ
    -fBodyAccMag
    -fBodyAccJerkMag
    -fBodyGyroMag
    -fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

    -mean(): Mean value
    -std(): Standard deviation
    -mad(): Median absolute deviation 
    -max(): Largest value in array
    -min(): Smallest value in array
    -sma(): Signal magnitude area
    -energy(): Energy measure. Sum of the squares divided by the number of values. 
    -iqr(): Interquartile range 
    -entropy(): Signal entropy
    -arCoeff(): Autorregresion coefficients with Burg order equal to 4
    -correlation(): correlation coefficient between two signals
    -maxInds(): index of the frequency component with largest magnitude
    -meanFreq(): Weighted average of the frequency components to obtain a mean frequency
    -skewness(): skewness of the frequency domain signal 
    -kurtosis(): kurtosis of the frequency domain signal 
    -bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
    -angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

    -gravityMean
    -tBodyAccMean
    -tBodyAccJerkMean
    -tBodyGyroMean
    -tBodyGyroJerkMean  


### DATA:
The data was made available for this project by download from the following site:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The .zip file included the following primary folders/files:
	- Folder of TEST data:
	  + subject_test.txt
	  + X_test.txt
	  + y_test.txt
	- Folder of TRAIN data:
	  + subject_train.txt
	  + X_train.txt
	  + y_train.txt
	- activity_labels.txt
	- features.txt
	- features_info.txt
	- README.txt

Additional details of the experiments conducted and data collected can be found within the above files.


### TRANSFORMATION OF DATA - CLEANING AND REORGANIZING:
All steps to process the data are included in the R function **data_analysis.R**, which is available in the repo on GitHub.   The following summarizes all steps taken within the function.   Please also refer to the listed step numbers, which are also included in comments within the R file.

IMPORTANT NOTE: The R script assumes you have downloaded the .zip file, placed it into the directory of your choice, unzipped it, and reset your working directory to point to that location.  These steps are necessary before running the script.

*_STEP001_* - Load the libraries to be used
To ensure correct processing of the script, the required libraries are loaded as the initial step in processing.

*_STEP002_* - Read the data files
The six data files of subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt, and y_train.txt are read into data frames:
	- subjectTRAIN - from subject_train.txt
	- xTRAIN - from x_train.txt
	- yTRAIN - from y_train.txt
	- subjectTEST - from subject_test.txt
	- xTEST - from x_test.txt
	- yTEST - from y_test.txt

*_STEP003_* - Merge the Subject and Activity data files, add column headers
The following files were combined for ease of processing:
	- fullTRAINSubAct - combination of subjectTRAIN, yTRAIN
	- fullTESTSubAct - combination of subjectTEST, yTEST 
	- fullSubAct - combination of fullTRAINSubAct, fullTESTSubAct
The column headings in fullSubAct were renamed to "subject" and "activity"

*_STEP004_* - Merge the X data files, add column headers
The following files were combined for ease of processing:
	- fullXfile - combination of xTRAIN, xTEST
Since the column headings for both data files were originally non-descriptive strings, they have been replaced in the fullXfile with the complete observation names as described in the features.txt file.

*_STEP005_* - Combine the Sub dataframe and the X data frame
The following files were combined to make one data frame:
	- fullData - combination of fullSubAct, fullXfile

*_STEP006_* - Extract all observations for mean and standard deviation
The original 561 columns of the X files were reduced to 66 observations by retaining only those observations that specified mean() and std() in logical pairs. This assumption was made since no specific instructions were given for which mean() and std() to retain.  The selections were made by reviewing the features.txt file, identifying the column numbers of the observations to be retained, and applying a filter of column numbers to the fullData data frame.
	- fullData2 - the resulting subset of fullData

*_STEP007_* - Add descriptive names to the activities column
A translation vector was used to replace the activity code number with its literal name, based on the entries in the activity_labels.txt file.
	- fullData2 - updated the entries in the fullData2$activity column

*_STEP008_* - Create a tidy data set with averages for each variable, activity, subject
The mean of each observation was calculated and sumed by using the aggregate() function.  Then the resulting data set was re-ordered by subject and then activitty for ease of use.   The resulting data set was saved as **TidyData.txt** and placed into the specified working directory.
	- fullData3 - the result of aggrigation on fullData2
	- fullData4 - the ordered output from fullData3
	- TidyData.txt - the output file created from fullData4

