## Readme

This is the README file for the programming assignment for the Coursera project for the Getting and Cleaning Data course. The outline of the R script, run_analysis.R, is as follows:

* Load the files relevant to the project
	+ Define paths of the files
	+ Load the Test files, Train files, Features and Activity files
* Merge the loaded train and test data frames into a large "mergedData" data frame
* Add column names using the features data frame
* Extract only those columns which either contain a Mean or a Std Dev
* Add Activity labels to the data frame using the activity data frame
* Generate averages
* Write final table as "Final Tidy Dataset.txt"