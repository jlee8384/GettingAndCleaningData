# GettingAndCleaningData

The run_analysis.R file does the following:

Downloads the dataset if it does not already exist in the working directory;
Loads the activity and feature info;
Loads both the training and test datasets;
Loads the activity and subject data for each dataset, and merges those columns with the dataset;
Merges the two datasets;
Converts the activity and subject columns into factors;
Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair;
Exports the tidy dataset to tidymeandata.txt;
