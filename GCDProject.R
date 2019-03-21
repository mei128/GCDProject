##
## GCDProject.R - mei128@infantes.com
##
## This script gets data from the UCI Machine Learning Repository and performs some cleaning (trimming
## unwanted variables) and tidying (add meaning to variable names and textual description of activity
## codes), and generates a simpler data set (tidy_data_1.csv) and a summary data set (tidy_data_2.csv)
##
## Built with "old" (but good) traditional C or Pascal style: some aux functions are defined first,
## and a main part of code that glues the logic together comes at the end.


library(readr) # for faster reading of data tables
library(dplyr)

##
##  Global Vars: URLs and file paths
##

baseDataURL        <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
baseDataZIP        <- "./baseData.zip"
baseDataPath       <- "./UCI HAR Dataset/"
tidyDataPath       <- "./tidyData/"
tidyDataSet1       <- "tidy_data_1.csv"
tidyDataSet2       <- "tidy_data_2.csv"
activity_labels_f  <- "./UCI HAR Dataset/activity_labels.txt"
features_f         <- "./UCI HAR Dataset/features.txt"
X_test_f           <- "./UCI HAR Dataset/test/X_test.txt"
subject_test_f     <- "./UCI HAR Dataset/test/subject_test.txt"
y_test_f           <- "./UCI HAR Dataset/test/y_test.txt"


## getBaseData
##
## Downloads and expands this project's base data (if it has not been done already). This allows
## us to replicate the basic dataset from the source in every platform, instead of pulling/pushing
## files from github (too large)

downloadBaseData <- function() {

    if (!dir.exists(baseDataPath)) {
        download.file(baseDataURL,destfile = baseDataZIP, method = "curl")
        unzip(baseDataZIP)
	file.remove(baseDataZIP)
    }
}

## readNumData
##
## Reads FWF data files with the 561 features vectors from the set (16 chars per column), and
## returns a tbl_df both test (top) and train (bottom) data stacked.
##
## Takes in the test data file path only (file structure must me congruent)

readNumData <- function(fname) {
    dtst  <- read_fwf(fname,fwf_widths(rep(16,561)),cols(.default=col_double()))  # read test data
    fname <- gsub("test","train",fname)                                           # replace 'test' by 'train'
    dtrn  <- read_fwf(fname,fwf_widths(rep(16,561)),cols(.default=col_double()))  # read train data
    return(rbind(dtst,dtrn))                                                      # stack'em up
}
    
## readIdData
##
## Reads single column files (subject ID and activity) and returns both test (top) and
## train (bottom) data stacked.
##
## Takes in the test data file path only (file structure must me congruent)

readIdData <- function(fname) {
    dtst  <- read.table(fname)              # read test data
    fname <- gsub("test","train",fname)     # replace 'test' by 'train'
    dtrn  <- read.table(fname)              # read train data
    return(rbind(dtst,dtrn))                # stack'em up
}

## writeTidyData
##
## Write tidy datasets as CSV file in output directory.
##

writeTidyData <- function(data,fname) {
    if (!dir.exists(tidyDataPath)) dir.create(tidyDataPath)         # make sure output folder exists
    write_csv(data,paste0(tidyDataPath,fname), col_names = TRUE)    # write data as CSV with header
}

## tidyNames
##
## Tidy up feature names to make them more readable, expanding some abbreviations and rearranging
## some labels. 

tidyNames <-function(uglynames) {
    cnames <- tbl_df(uglynames) %>%                             # Pipe transformations to column names
        mutate(value = sub("\\.\\.","",value)) %>%
        mutate(value=sub("\\.mean\\.X",".X.mean",value)) %>%
        mutate(value=sub("\\.mean\\.Y",".Y.mean",value)) %>%
        mutate(value=sub("\\.mean\\.Z",".Z.mean",value)) %>%
        mutate(value=sub("\\.mean\\.X",".X.mean",value)) %>%
        mutate(value=sub("\\.mean\\.Y",".Y.mean",value)) %>%
        mutate(value=sub("\\.mean\\.Z",".Z.mean",value)) %>%
        mutate(value=sub("\\.std\\.X",".X.stdev",value)) %>%
        mutate(value=sub("\\.std\\.Y",".Y.stdev",value)) %>%
        mutate(value=sub("\\.std\\.Z",".Z.stdev",value)) %>%
        mutate(value=sub("Body","Body.",value))          %>%
        mutate(value=sub("Gravity","Gravity.",value))    %>%
        mutate(value=sub("AccJerk","Acc.Jerk",value))    %>%
        mutate(value=sub("AccMag","Acc.Mag",value))      %>%
        mutate(value=sub("GyroJerk","Gyro.Jerk",value))  %>%
        mutate(value=sub("GyroMag","Gyro.Mag",value))    %>%
        mutate(value=sub("JerkMag","Jerk.Mag",value))    %>%
        mutate(value=sub("Acc","Acceleration",value))    %>%
        mutate(value=sub("Gyro","Angular",value))        %>%
        mutate(value=sub("Mag","Magnitude",value))       %>%
        mutate(value=sub("^t","t.",value))               %>%
        mutate(value=sub("^f","f.",value))
    return(cnames$value)
}

## meanBySubjectActivy
##
## Summarize data set to the mean in every variable, grouping by subject and activy

meanBySubjectActivy <- function(dataset) {
    result <- dataset %>%                             # pipe operations
        group_by(Subject,Activity) %>%                # group by Subject and Activity
        summarize_all(mean)                           # summarize with the mean of all vars (except group)
    return(result)
}
## 
## MAIN
##

# Step 0 - Read data files. Var names are self explanatory

downloadBaseData()
activity_names <- read.table(activity_labels_f, row.names = 1, colClasses = c("integer","character"))
feature_names  <- read.table(features_f, row.names = 1, colClasses = c("integer","character"))
features       <- readNumData(X_test_f)
activity       <- readIdData(y_test_f)
subject        <- readIdData(subject_test_f)
feature_names  <- c("Subject","Activity",make.names(feature_names[,1],unique = TRUE))  # Valid col names

## Step 1 - Combine columns and columnnames

baseData           <- cbind(subject,activity,features)  # Combine columns
colnames(baseData) <- feature_names                     # and column names
rm("features","activity","subject")                     # clean-up environment (not really needed)

## Step 2 - Trim data, leaving only Subject, Activity, and mean and standard deviations of measurements

baseData <- select(baseData,grep("Subject|Activity|mean\\.|std\\.",names(baseData),value=TRUE))

## Step 3 - Replace activity codes with descriptive text

baseData <- mutate(baseData,Activity = activity_names[Activity,1])

# Step 4 - Tidy column names to provide meaningful data. Data set is ready.

feature_names      <- tidyNames(names(baseData))
colnames(baseData) <- feature_names

writeTidyData(as.data.frame(feature_names),"labels.txt") # dump names to write the code book later

# Step 5 - Write first data set: simpler and tidier

writeTidyData(baseData,tidyDataSet1)

# Step 6 - Summarize all vars on their mean, groupd by Subject and Activity

summaryData <- baseData         %>%      # Start by piping base data
    group_by(Subject,Activity)  %>%      # group output by Subject and Activity
    summarize_all(mean)                  # summarize all on their mean

# Step 7 - Write second data set: summary version of the first

writeTidyData(summaryData,tidyDataSet2)

# View(baseData)
# View(summaryData)
