# GettingAndCleaningData Program assignment

## Project scope
The project read data from [archive.ics.uci.edu] and manipulate it in order to obtain a better tidy rappresentation, usefull for further investigation.

The code in run_analysis.R main steps are:
* read original dataset
* merge test and train data
* remove uninteresting variables
* label the variables with clean and understandable names
* assign to any observation (one for each row) the corresponding subject and activity (in readable format)
* compute mean statistic for any variable through many observations for same subject and activity
* save data to an output file (meanData.txt)

## Output file
Output file contains 180 rows and 81 variables:
* activity: the activity performed during the data reading
* subject: id of the subject who makes the ativity
* ...: the mean of the particular measurement. Check features.txt contains the list of the feature (only mean & std are observed) feature_info.txt contains some descriptions of it. 

Note: Column names are the same in features.txt but lowercased and the caracters '(', ')' and '-' where removed for better readibility.




[archive.ics.uci.edu]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
