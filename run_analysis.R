library(tidyverse)
library(readr)
library(stringr)

# Imports
x_train <- read_table(file = "~/Data Science Accelerator/UCI HAR Dataset/train/X_train.txt", col_names = FALSE)
y_train <- read_table("~/Data Science Accelerator/UCI HAR Dataset/train/y_train.txt", col_names = FALSE)
subject_train <- read_table(file = "~/Data Science Accelerator/UCI HAR Dataset/train/subject_train.txt", col_names = FALSE)
x_test <- read_table("~/Data Science Accelerator/UCI HAR Dataset/test/X_test.txt", col_names = FALSE)
y_test <- read_table("~/Data Science Accelerator/UCI HAR Dataset/test/y_test.txt", col_names = FALSE)
subject_test <- read_table(file = "~/Data Science Accelerator/UCI HAR Dataset/test/subject_test.txt", col_names = FALSE)
features <- read.table("~/Data Science Accelerator/UCI HAR Dataset/features.txt")
activity_labels <- read_table("~/Data Science Accelerator/UCI HAR Dataset/activity_labels.txt", col_names = FALSE)


# Combine data sets
# nrow(subject_test) + nrow(subject_train)
subject_full <- rbind(subject_train, subject_test)
# nrow(subject_full)

# ncol(x_train)
# ncol(x_test)
# nrow(x_train) + nrow(x_test)
x_full <- rbind(x_train, x_test)
# nrow(x_full)

# nrow(y_test) + nrow(y_train)
y_full <- rbind(y_train, y_test)
# nrow(y_full)
# levels(as.factor(y_full$X1))

# 4.
# Add meaningful column headers
colnames(features) <- c("colNum", "colName")
colnames(x_full) <- features$colName
colnames(y_full) <- "activity"
colnames(subject_full) <- "subjectNum"

# 3.  
# Make y a factor variable
y_full$activity <- plyr::revalue(as.factor(y_full$activity), c("1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING"
                           , "5" = "STANDING", "6" = "LAYING"))
levels(y_full$activity)

# 2.
# Subset the x table to only have metrics for the mean and standard deviation of each measurement
x_full_sub <- x_full[, grep("mean|std", colnames(x_full))]

# 1.
# Bind the subject, y, and x subset together
complete <- cbind(subject_full, y_full, x_full_sub)
# nrow(complete)
# ncol(complete)
# glimpse(complete)
# View(complete)

# 5.
# Summarized table by subjectNum and activity
complete_summary <- complete %>%  
  group_by(subjectNum, activity) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE)

write.table(complete_summary, file = "coursera_project_week4.txt", row.name=FALSE)
