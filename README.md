## Transformations from original data to the tidy data: procedures taken by run_analysis.R

We performed a series of transformations on the raw data following the instructions from the project homepage. Below is a summary of the procedures taken by the run_analysis.R file.
- The train and test data for X were combined to form a single data set with 10299 observations (records). Similar combinations were carried out also for y and subject. 
- The numeric labels about activity (integer 1 to 6) contained in the combined y vector were replaced by the corresponding descriptive names (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
- For the combined X data frame, features with names that do not contain the key words "mean" or "std" were excluded from the data. Only 79 features out of the original 561 remained in X after this step.
- The variable names of y, subject and X (originally as V1, V2, V3, etc.) were replaced by "activity", "subject", and the corresponding descriptive names in the "features.txt" file such as "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z" etc.
- The subject and y vectors were added to X as the first and second colomns of the combined data frame acc. acc had therefore 81 columns. 
- A new data frame accave was created to contain the average of each of the total 79 features for each activity (out of the total 6 activities) and each subject (out of the total 30 subjects). So accave had 30 * 6 = 180 rows and 79 columns. 
- accave was written to a file named as "tidy_data_upload.txt". Note that the 79 features in accave had the same column names as the 79 features in acc, though the former represented the sample means as indicated above.