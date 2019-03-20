##
## Step_1_GetData.R - mei128@infantes.com
##
## This script downloads source data, reads it in manageable structures, and stacks test and train data

library(readr) # for faster reading of data tables
library(dplyr)

##
##  Global Vars: URLs and file paths
##

baseDataURL        <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
baseDataZIP        <- "./baseData.zip"
baseDataPath       <- "./UCI HAR Dataset"
activity_labels_f  <-"./UCI HAR Dataset/activity_labels.txt"
features_f         <-"./UCI HAR Dataset/features.txt"
X_test_f           <-"./UCI HAR Dataset/test/X_test.txt"
subject_test_f     <-"./UCI HAR Dataset/test/subject_test.txt"
y_test_f           <-"./UCI HAR Dataset/test/y_test.txt"


## getBaseData
##
## Downloads and expands this project's base data (if it has not been done already). This allows
## us to replicate the basic dataset from the source in every platform, instead of pulling/pushing
## files from github (too large)

downloadBaseData <- function() {

    if (!file.exists(baseDataPath)) {
        download.file(baseDataURL,destfile = baseDataZIP, method = "curl")
        unzip(baseDataZIP)
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
        mutate(value=sub("^f","f..",value))
    return(cnames$value)
}

## 
## MAIN
##

# Step 0 - Read data files. Var names are self explanatory

activity_names <- read.table(activity_labels_f, row.names = 1, colClasses = c("integer","character"))
feature_names  <- read.table(features_f, row.names = 1, colClasses = c("integer","character"))
features       <- readNumData(X_test_f)
activity       <- readIdData(y_test_f)
subject        <- readIdData(subject_test_f)
feature_names  <- c("Subject","Activity",make.names(feature_names[,1],unique = TRUE))  # Valid col names

## Step 1 - Combine columns and columnnames

baseData           <- cbind(subject,activity,features)  # Combine columns
colnames(baseData) <- feature_names                     # and column names

## Step 2 - Trim data, leaving only Sibject, Activity, and mean and standard deviations of measurements

baseData <- select(baseData,grep("Subject|Activity|mean\\.|std\\.",names(baseData),value=TRUE))

## Step 3 - Replace activity codes with descriptive text

baseData <- mutate(baseData,Activity = activity_names[Activity,1])

# Step 4 - Tidy column names to provide meaningful data

feature_names      <- tidyNames(names(baseData))
colnames(baseData) <- feature_names

write.table(feature_names,"labels") # dump names to write te code book later

# Dump data set to upload to Github

write_csv(baseData,"tidy_data_1.csv", col_names = TRUE)
