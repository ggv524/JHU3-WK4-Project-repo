===========================================================
##JHU3: Week 4 - Course Project - Getting and Cleaning Data
##Version 1.0
===========================================================
###GetHub repo: JHU3-WK4-Project-repo

The purpose of this repo is to provide all needed elements for our analysis of the Human Activity Recognition Using Smartphones Dataset.

This repo contains the following script and files:

1. run_analysis.R - This is an R script that processes the the input data
2. CodeBook.md - Documentation which describes the variables, data, and all transformations that were applied to the data
3. This README.md file

Submitted separately on the Coursera site:

1. TidyData.txt - The output from run_analysis.R.


###Reading the TidyData.txt file:
==============================
In order to review the output file in RStudio, update the "file_path" appropriately for your environment and use the following command:

	data <- read.table("./TidyData.txt", header = TRUE) 
	View(data)


###License:
========
Use of the original dataset and supporting documentation is granted by:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
