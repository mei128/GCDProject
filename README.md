# GCDProject
## *Getting and Cleaning Data* Class Project Script ##
The purpose of this project is to practice the skills for getting and cleaning data to produce tidy data sets. All the code for this project is contained in a single R script file called 'GCDProject.R'  

The code is structured in a conventional 'C' language style, with some global variables declared first, then some functions that perform simple individual tasks, and a main body part that glues all the logic together. The global vars declared at the begining are URL and path names, in order to keep code tidy and readable,instead of having long path names embedded in the code.  

### Step 0 ###
The function downloadBaseData checks if we already have the original data to work with. If we don't, it downloads the ZIP file and expands it in the working directory. Then we read all individual data tables. Numeric data comes in fixed width format files that we read with the function readNumData. This function reads both test and train data sets (read code_book.md) and stacks them up in a single table data frame, making use of the readr package for faster reading. Similarly, readIdData is used to read index files, subject and activity code for each vector of features of the test and train data sets, and stack them up. Finally, the feature names read are not valid variable names (contain invalid symbols), and have to be made valid (make.names) and unique. The feature names list is pre-pended with two elements, "Subject" and "Activity," to provide variable names for those columns.  
```{r eval=FALSE}
downloadBaseData()  
activity_names <- read.table(activity_labels_f, row.names = 1, colClasses = c("integer","character"))  
feature_names  <- read.table(features_f, row.names = 1, colClasses = c("integer","character"))  
features       <- readNumData(X_test_f)  
activity       <- readIdData(y_test_f)  
subject        <- readIdData(subject_test_f)  
feature_names  <- c("Subject","Activity",make.names(feature_names[,1],unique = TRUE))  # Valid col names  
```
At this moment we have read and stored subject ids (subject), activity ids (activity) and names (activity_names), feature vectors (features) and names (feature_names).
### Step 1 ###
Subject ids, activity ids, and feature vectors are all column bound to create a single table, to which we asign the feature names as column names. 
```{r eval=FALSE}
baseData           <- cbind(subject,activity,features)  # Combine columns  
colnames(baseData) <- feature_names                     # and column names  
```
### Step 2 ###
We trim the data set by selecting only Subject, Activity, and those columns which contain mean and standard deviation features.  After the make.names statement, 'mean()' became 'mean..', and 'std()' became 'std..', hence the trailing '\\.' for both in the select statement. Note that features like 'fBodyAcc-meanFreq' in the original data set are not really means of measurements taken.
```{r eval=FALSE}
baseData <- select(baseData,grep("Subject|Activity|mean\\.|std\\.",names(baseData),value=TRUE))
```
### Step 3 ###
In the original data set the activity performed by the subject is indicated with an index, that we now replace with a meaningful text descriptions from the activity_names table.
```{r eval=FALSE}
baseData <- mutate(baseData,Activity = activity_names[Activity,1])
```
### Step 4 ###
The function tidyNames expands abbreviations in column names to their full meaning (i.e. Acc to Acceleration), separates terms with dots, replaces leading 't' and 'f' with 'time' and 'freq' to indicate time based or frequency based data, and postfixes names with '.mean' or 'stdev' as required.
```{r eval=FALSE}
feature_names      <- tidyNames(names(baseData))
colnames(baseData) <- feature_names
```
### Step 5 ###
The resulting data set, now clean and tidy, is saved. The writeTidyData function makes sure the tidyData folder exists before writing the data set as csv file.
```{r eval=FALSE}
writeTidyData(baseData,tidyDataSet1)

```
### Step 6 ###
Finally, data is grouped by Subject and Activity, and summarized on the mean of all features, resulting in a single vector per subject-activity pair. The summary data set is written to the tidyData folfder.
```{r eval=FALSE}
summaryData <- baseData         %>%      # Start by piping base data
    group_by(Subject,Activity)  %>%      # group output by Subject and Activity
    summarize_all(mean)                  # summarize all on their mean

writeTidyData(summaryData,tidyDataSet2)

```

### Data sets ###
File tidyData/tidy_data_1.csv contains 10299 vectors with 66 features, plus the subject and the activity being performed.  
File tidyData/tidy_data_2.csv contains 180 vectors with 66 features, which are the average of the individual features per subject and activity.


