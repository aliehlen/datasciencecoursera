# R script for Getting and Cleaning Data course project
# 
# Data from UCI Human Activity Recognition Using Smartphones Data Set

pacman::p_load(data.table, tidyr)
setwd("~/Documents/Coursera_datascience/datasciencecoursera/getting_cleaning_data/")


# ---- get the data ----

# if (!dir.exists("datasets")) dir.create("datasets")
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#     destfile = "datasets/hardata.zip", mode = "wb")
# # creates folder called "UCI HAR Dataset" in same directory
# unzip("datasets/hardata.zip")


# ---- pull together full dataset ----

setwd("datasets/UCI HAR Dataset/")

# get test data, add column for activities and subjects
testdata = fread("test/X_test.txt")
testact = fread("test/y_test.txt", col.names = "activitylabel")
testsubj = fread("test/subject_test.txt", col.names = "subject")

testdata = cbind(testact, testsubj, testdata)

# get train data, add column for activities and subjects
traindata = fread("train/X_train.txt")
trainact =  fread("train/y_train.txt", col.names = "activitylabel")
trainsubj = fread("train/subject_train.txt", col.names = "subject")

traindata = cbind(traindata, trainact, trainsubj)

# combine test and train data
alldata = rbind(testdata, traindata)

# get and clean activity labels, add to alldata
actlab = fread("activity_labels.txt", col.names = c("activitylabel", "activity"))
actlab[,activity := tolower(activity)]
actlab[,activity := gsub("_","",activity)]

alldata = merge(alldata, actlab, by = c("activitylabel"))

# get feature (column) labels, add to alldata
featurelabs = fread("features.txt", col.names = c("featurelab", "feature"))

setnames(alldata, paste0("V",1:561), featurelabs$feature)

# keep only mean and standard deviation columns (excluding meanFreq)
featurelabs = featurelabs[grepl("mean\\(\\)|std\\(\\)", feature)]

alldata = alldata[, .SD, .SDcols = c("subject", "activity", featurelabs$feature)]
alldata1 = copy(alldata)

# ---- clean alldata ----

# add timeseries marker so can separate mean and sd later
alldata[, row := 1:.N, by = c("subject", "activity")]

# alldata now has only the columns we are interested in. melt to more easily 
# clean up the feature variable names.
# tidyr functions are really slow on this dataset, so using data.table

alldata = melt(alldata, id.vars = c("subject", "activity", "row"), 
               variable.name = "feature")
alldata[,feature := as.character(feature)]

# separate time and frequency measurements
alldata[,c("domain", "feature") := .(substr(feature,1,1), 
                                     substr(feature,2,nchar(feature)))]

# separate x, y, z, and magnitude measurements
alldata[grepl("Mag", feature),c("direction", "feature") := 
                              .("magnitude", gsub("Mag", "", feature))]
alldata[is.na(direction), c("direction", "feature") := 
                          .(substr(feature, nchar(feature),nchar(feature)), 
                            substr(feature, 1, nchar(feature)- 2))]

# separate summary type
alldata[, c("feature", "summarytype") := tstrsplit(feature, '-')]
alldata[,summarytype := gsub("\\(\\)", "", summarytype)]
alldata[summarytype == "std", summarytype := "standarddev"]

# separate mean and sd out again
alldata = dcast(alldata, 
                row+subject+activity+feature+domain+direction~summarytype, 
                value.var = "value")
alldata[, row := NULL]

# write out full tidy data set
write.csv(alldata, "../alldata_mean_std.csv", row.names = F, quote = F)


# ---- create summary data set of averages ----

# take mean by all variables
summarydata = alldata[,.(averagemean = mean(mean, na.rm = T),
                         averagestandarddev = mean(standarddev, na.rm = T)), 
                      by = c("subject", "activity", "feature", "domain", 
                             "direction")]

# write out average tidy data set
write.csv(summarydata, "../../summarydata_mean_std.csv", row.names = F, quote = F)
