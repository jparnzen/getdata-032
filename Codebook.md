# Course Project Code Book

## Source Data Notes
The source dataset consists of the merged training and testing data from the original experiment. After merging the data in Step 1 of the project description, we have a dataset with 563 columns and 10299 rows -- SubjectID, ActivityID, and the 561 feature columns. Documentation for these columns can be found as part of the original zipped data in the README.txt and features_info.txt files.

## Intermediary Data Notes
Attempts were made to follow tidy data principles. The wide data format of the source was melted down to separate some of the joined data elements, resulting in a longer, narrower dataset. For example, a source data column such as "tBodyAcc-mean()-X" was decomposed into 4 separate columns: a Domain column for "t" (time domain), a Feature column for "BodyAcc", a Statistic column for "mean", and a Dimension column for "X".

### Intermediary Data Columns & Values
1 SubjectID: numeric; original subject identifier
    * 1-30
2 Activity: string; activity performed and measured during study
    * WALKING
    * WALKING_UPSTAIRS
    * WALKING_DOWNSTAIRS
    * SITTING
    * STANDING
    * LAYING
3 Domain: character; domain of measurement
    * t (time domainO)
    * f (frequency domain)
4 Feature: string; specific component features from original study data
    * BodyAcc
    * GravityAcc
    * BodyAccJerk
    * BodyGyro
    * BodyGyroJerk
    * BodyAccMag
    * GravityAccMag
    * BodyAccJerkMag
    * BodyGyroMag
    * BodyGyroJerkMag
    * BodyBodyAccJerkMag
    * BodyBodyGyroMag
    * BodyBodyGyroJerkMag
5 Statistic: string; statistic used in feature from original study data
    * mean
    * std (standard deviation)
6 Dimension: char; optional dimension of feature vectors
    * X
    * Y
    * Z
    * (no dimension: empty string)
7 Measurement: numeric; original value measurement from original study data

## Result Data Notes
The result dataset represents the final dataset for Step 5 of the project description. It presents the aggregate mean of feature measurements for each activity of each subject.

### Result Data Columns & Values
* SubjectID: numeric; same as above, used as the primary grouping element
* Activity: string; same as above, used as the secondary grouping element
* mean(Measurement): numeric; aggregate mean of features, for each activity for each subject