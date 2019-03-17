##
## GCDProject.R - mei128@infantes.com
##
## This file groups all functions and steps for the completion of the Getting and Cleaning Data course project.
library(readr)
## getBaseData
##
## Function to download and expand this project's base data. This allows us to replicate the basic
## dataset from the source in every platform, instead of pulling them from github (too large)
##
getBaseData <- function() {
    baseDataURL  <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    baseDataZIP <- "./baseData.zip"
    baseDataPath <- "./UCI HAR Dataset"

    if (!file.exists(baseDataPath)) {
        download.file(baseDataURL,destfile = baseDataZIP, method = "curl")
        unzip(baseDataZIP)
    }
}

activity_labels_f   <-"./UCI HAR Dataset/activity_labels.txt"
features_f          <-"./UCI HAR Dataset/features.txt"
X_test_f            <-"./UCI HAR Dataset/test/X_test.txt"
subject_test_f      <-"./UCI HAR Dataset/test/subject_test.txt"
y_test_f            <-"./UCI HAR Dataset/test/y_test.txt"
body_acc_x_test_f   <-"./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"
body_acc_y_test_f   <-"./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"
body_acc_z_test_f   <-"./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"
body_gyro_x_test_f  <-"./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"
body_gyro_y_test_f  <-"./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"
body_gyro_z_test_f  <-"./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"
total_acc_x_test_f  <-"./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"
total_acc_y_test_f  <-"./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"
total_acc_z_test_f  <-"./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"
X_train_f           <-"./UCI HAR Dataset/train/X_train.txt"
subject_train_f     <-"./UCI HAR Dataset/train/subject_train.txt"
y_train_f           <-"./UCI HAR Dataset/train/y_train.txt"
body_acc_x_train_f  <-"./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt"
body_acc_y_train_f  <-"./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt"
body_acc_z_train_f  <-"./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt"
body_gyro_x_train_f <-"./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"
body_gyro_y_train_f <-"./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"
body_gyro_z_train_f <-"./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"
total_acc_x_train_f <-"./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"
total_acc_y_train_f <-"./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"
total_acc_z_train_f <-"./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"

# dt<-read_fwf(body_acc_x_test_f,fwf_widths(rep(16,128)))

etest <- function() {
    e <- globalenv()
    e$f -> "Hola"
}