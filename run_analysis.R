library(data.table)
library(tidyr)
library(dplyr)

## FROM THE PROJECT ASSIGNMENT:
## You should create one R script called run_analysis.R that does the following:
##
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.

## ASSUMPTIONS:
## * the data zipfile has been downloaded and unzipped into its own subdirectory
## * the data subdirectory has been renamed to "data"
## * the data subdirectory has a well-known structure and content

run_analysis <- function() {
    data.dir <- "data"
    
    ## prep activities & features
    activities <- prepActivities(data.dir)
    features <- prepFeatures(data.dir)
    
    step1 <- readAndMergeDatasets(data.dir, "train", "test")
    setnames(step1, c("SubjectID", features$Feature, "ActivityID"))
    
    step2 <- extractMeansAndStds(step1)
    step3 <- addDescriptiveActivityNames(step2, activities)
    step4 <- tidyFeatures(step3)
    step5 <- leGrandeAverages(step4)
    
    ## step5 is a grouped_dt, so convert it to a dataframe for full display
    as.data.frame(step5)
}

# ---------------------------------------------------------------------------- #
# Helper Functions for the main function above
# ---------------------------------------------------------------------------- #
prepActivities <- function(data.dir) {
    fread(file.path(data.dir, "activity_labels.txt"),
          col.names = c("ID", "Activity"))
}

prepFeatures <- function(data.dir) {
    fread(file.path(data.dir, "features.txt"),
          col.names = c("ID", "Feature"))
}

readAndMergeDatasets <- function(data.dir, train.subdir, test.subdir) {
    train.files <- list.files(file.path(data.dir, train.subdir),
                              pattern = "\\.txt$",
                              full.names = T,
                              ignore.case = T)
    train.ds <- lapply(train.files, fread)
    train.data <- do.call(cbind, train.ds)

    test.files <- list.files(file.path(data.dir, test.subdir),
                             pattern = "\\.txt$",
                             full.names = T,
                             ignore.case = T)
    test.ds <- lapply(test.files, fread)
    test.data <- do.call(cbind, test.ds)
    
    do.call(rbind, list(train.data, test.data))
}

extractMeansAndStds <- function(dataset) {
    select(dataset, SubjectID, contains("mean()"), contains("std()"), ActivityID)
}

addDescriptiveActivityNames <- function(dataset, activities) {
    m <- merge(dataset, activities, by.x = "ActivityID", by.y = "ID", sort = F)
    m$ActivityID <- NULL
    m
}

tidyFeatures <- function(dataset) {
    gather(dataset, Feature, Measurement, -Activity, -SubjectID) %>%
        separate(Feature, c("Feature", "Statistic", "Dimension")) %>%
        separate(Feature, c("Domain", "Feature"), sep = 1)
}

leGrandeAverages <- function(dataset) {
    dataset %>% group_by(SubjectID, Activity) %>% summarise(mean(Measurement))
}
