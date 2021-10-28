# Getting-and-Cleaning-Data-Project

Prepare and read the data for tidy
The script is to prepare tidy data that can be used for later analysis, the data is from UCI HAR Dataset.
The following files from the downloaded dataset are used:
1.	features.txt - includes the descriptions for features measured
2.	X_test.txt - includes the measurements of the features in test set
3.	y_test.txt - activity (from 1 to 6) for each measurement from the test set
4.	subject_test.txt - subject for each measurement from the test set
5.	X_train.txt - includes the measurements of the features in train set 
6.	y_train.txt - activity (from 1 to 6) for each measurement from the train set
7.	subject_train.txt - subject for each measurement from the train set

How script works
1.	After download zip. File, read file folder by folder, file by file.
2.	Convert test and train data set into a single data frame respectively. Extract descriptions for features measured from features.txt. Use these descriptions to name the two data frames respectively.
3.	Merge the labeled data frames into one.
4.	To extract measurements that involves only mean and standard deviation values script uses grep.
5.	Uses descriptive activity names to name the activities in the data set by reading the labels from the activity_labels.txt file.
6.	Replace the names in data set with names from activity labels.
7.	Create the final tidy data using aggregate grouped by activity and subject. Then write table.
