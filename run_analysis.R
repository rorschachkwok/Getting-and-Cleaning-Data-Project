
# download.file -----------------------------------------------------------

setwd("C:/Users/gyc/Desktop/coursera/har_dataset/")
fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./har_dataset.zip')) {
        download.file(fileUrl, './har_dataset.zip', mode = 'wb')
        unzip('./har_dataset.zip', exdir = getwd())
}


# read file folder by folder ----------------------------------------------

features <- read.table('UCI HAR Dataset/features.txt')
features <- as.character(features[ ,2])

x_test <- read.table('UCI HAR Dataset/test/X_test.txt')
y_test <- read.table('UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt')
data_test <- data.frame(x_test, y_test, subject_test)
names(data_test) <- c(features, c('activity', 'subject'))

x_train <- read.table('UCI HAR Dataset/train/X_train.txt')
y_train <- read.csv('UCI HAR Dataset/train/y_train.txt', header = F, sep = ' ')
subject_tain <- read.table('UCI HAR Dataset/train/subject_train.txt')
data_train <- data.frame(x_train, y_train, subject_tain)
names(data_train) <- c(features, c('activity', 'subject'))


# merge test and train ----------------------------------------------------

data_merge <- rbind(data_test, data_train)

# extract -----------------------------------------------------------------

data_extract <- grep('mean|std', features)
data_extract <- data_merge[, c(data_extract, 562, 563)]

# to name the activities in the dataset -----------------------------------

activity_lables <- read.table('UCI HAR Dataset/activity_labels.txt') 
activity_lables <- as.character(activity_lables[, 2])
data_merge$activity <- activity_lables[data_merge$activity]

# label the dataset with descriptive variable names -----------------------

col_names <- colnames(data_extract)
col_names <- gsub("[()]", '', col_names)
col_names <- gsub('^f', 'FrequencyDomain_', col_names)
col_names <- gsub('^t', 'TimeDomain', col_names)
col_names <- gsub('Acc', 'Acceletometer', col_names)
col_names <- gsub('Gyro', 'Gyroscope', col_names)
col_names <- gsub('Mag', 'Magnitude', col_names)
col_names <- gsub('-mean-', '_Mean_', col_names)
col_names <- gsub('-std', ' _StandardDeviation_', col_names)
col_names <- gsub('-', '_', col_names)
colnames(data_extract) <- col_names

# write a tidy dataset ----------------------------------------------------

data_tidy <- aggregate(data_extract[, 1:79], by = list(activity = data_extract$activity, 
                                                       subject = data_extract$subject), FUN = mean)
write.table(x = data_tidy, file = 'data_tidy.txt', row.names = F)


# rm individual tables ----------------------------------------------------

rm(y_test, x_train, x_test, subject_tain, subject_test, data_train, data_test, y_train, data_merge)
