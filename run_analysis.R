
run_analysis <- function() {


require("reshape2")
require("data.table")
    
##########################################################
# "features" are the signal names.  e.g. "tBodyAcc-mean()-X"
##########################################################
features <- read.table("features.txt")[, 2]
# Extract the mean and standard deviation columns only.
features_mean_std <- grepl("mean|std", features)



##########################################################
# Activity Labels
##########################################################
# Activity Labels are e.g.:
# WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
activity_labels <- read.table("activity_labels.txt")[ , 2]



##########################################################
# TEST Data
##########################################################
data_x_test <- read.table("./test/X_test.txt")
names(data_x_test) <- features
data_x_test <- data_x_test[ , features_mean_std]

# "y_test" is the numbered version of the activity.
data_y_test <- read.table("./test/y_test.txt")
# Now replace the numbers with the actual labels.
data_y_test[ , 1] <- activity_labels[data_y_test[ , 1]]
names(data_y_test) <- "Activity_Label"

# "Subject" refers to the individual.
subject_test <- read.table("./test/subject_test.txt")
names(subject_test) <- "Subject"



##########################################################
# TRAIN Data
##########################################################
data_x_train <- read.table("./train/X_train.txt")
names(data_x_train) <- features
data_x_train <- data_x_train[ , features_mean_std]

# "y_test" is the numbered version of the activity.
data_y_train <- read.table("./train/y_train.txt")
# Now replace the numbers with the actual labels.
data_y_train[ , 1] <- activity_labels[data_y_train[ , 1]]
names(data_y_train) <- "Activity_Label"

# "Subject" refers to the individual.
subject_train <- read.table("./train/subject_train.txt")
names(subject_train) <- "Subject"



##########################################################
# Put the columns together.
##########################################################
test_data <- cbind(subject_test, data_y_test, data_x_test)
train_data <- cbind(subject_train, data_y_train, data_x_train)

#write.table(test_data, "test_data.txt", row.names=FALSE)
#write.table(train_data, "train_data.txt", row.names=FALSE)



##########################################################
# Put the rows together.
##########################################################
merged_table <- rbind(test_data, train_data)
#write.table(final_table, "final_table.txt", row.names=FALSE)



##########################################################
#  Use "melt" to split the data into "Subject" and
#  "Activity_Label" and then find the mean of the "features".
##########################################################
# The following removes the column labels "Subject" and "Activity_Label".
measure_vars <- setdiff(colnames(merged_table), c("Subject", "Activity_Label"))
#print(head(measure_vars))
melt_mean_data <- melt(merged_table, id = c("Subject", "Activity_Label"), measure.vars = measure_vars)

# Using "dcast" to find the mean.
tidy_data_mean_std <- dcast(melt_mean_data, Subject + Activity_Label ~ variable, mean)

write.table(tidy_data_mean_std, "tidy_data_mean_std.txt", row.names = FALSE)


}
