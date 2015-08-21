## load train and test data

X_train = read.table("UCI HAR Dataset/train/X_train.txt");
y_train = read.table("UCI HAR Dataset/train/y_train.txt");
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")

X_test = read.table("UCI HAR Dataset/test/X_test.txt");
y_test = read.table("UCI HAR Dataset/test/y_test.txt");
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")


## merge the train and test data

X = rbind(X_train, X_test);
y = rbind(y_train, y_test);
subject = rbind(subject_train, subject_test);


## Use descriptive names to name the activities in the dataset

activity_labels = read.table("UCI HAR Dataset/activity_labels.txt");
y$V1 = as.factor(y$V1);
levels(y$V1) = activity_labels[, 2];


## load the features vector and find out the variables whose names contain the key words "mean" or "std"

features = read.table("UCI HAR Dataset/features.txt");
fmean = grep("mean", features$V2);
fstd = grep("std", features$V2);
f = sort(c(fmean, fstd));
fname = features$V2[f];


## exclude the non-mean or non-sd variables from the data frame

X = X[, f];


## label the data set with descriptive variable names

colnames(X) = fname;
colnames(y) = "activity";
colnames(subject) = "subject";


## combine subject, y , and X into a single data frame

acc = cbind(subject, y, X);


## Create a new data set with the average of each variable for each activity and each subject

library(plyr);

accave = data.frame(subject = rep(seq(1, 30, length.out = 30), each = 6));
accave = mutate(accave, activity = rep(activity_labels[, 2], times = 30));

group = list(acc$subject, acc$activity);

for (k in seq(3, 81, length.out = 79))
{
	data = as.vector(t(matrix(tapply(acc[, k], group, mean))));
	accave = cbind(accave, data);
	colnames(accave)[k] = colnames(acc)[k];
}


## write the new data frame to a table

write.table(accave, "tidy_data_upload.txt", row.name = FALSE);