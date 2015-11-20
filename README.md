# CourseProject-GettingAndCleaningData

The following is a description of how the script "run_analysis.R" works:

1.  The "features.txt" file is read.  "features" are the signal names.  (e.g. "tBodyAcc-mean()-X")
2.  Using grepl, a boolean table "features_mean_std" is created which extracts only the "mean" and "std" features in "features.txt".
3.  Now X_test.txt, X_train.txt are read and then ANDed with "features_mean_std" to extract only the mean and std features.
4.  y_test.txt and y_train.txt are read. These are numbered versions of the activity.
5.  The numbered versions of activity are replaced by the actual full name of the activity.
6.  "subject_test.txt" and "subject_train.txt" are read. This data becomes the first column of the data.table we'll create.
7.  The data.table consists of the following columns:
    Subject, Activity_Label, and all the features that have mean and std in them.
8.  Now merge the test and training tables into one table.
9.  Add the column headers.
10.  Using melt and dcast, calculate the mean of Activities, per Subject.
11. Write the final table to a file, omitting the row labels.
