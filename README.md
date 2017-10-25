# Code Description
Comments  in file explain how the code works. Below are a list of any created variables. For a full description of the original datasets, visit http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 


Variables by dataset:

features:
-colNum: order of columns
-colName: column name

y_full = rbind(y_train, y_test):
-activity: factor variable for activity done by participant: "1" = "WALKING", "2" = "WALKING_UPSTAIRS", "3" = "WALKING_DOWNSTAIRS", "4" = "SITTING",
           "5" = "STANDING", "6" = "LAYING"

