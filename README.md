# README for Course Project
Quick notes and explanations on my approach to solving our assigned course project.

## Libraries Used
* `data.table`: provides fast reading of data files into an optimized and efficient data table structure, with a similar set of actions and behaviors to base R data frames.
* `tidyr`: provides functions for actions frequently performed when tidying data (separating and gathering data variables)
* `dplyr`: provides fast and database-like operations on data tables and data frames (selecting, grouping, and summarizing)

## Assumptions
* Some assumptions are documented in the comments for my code.
* `run_analysis()` assumes that the data files live in a `data` subdirectory off of the working directory, and that `train` and `test` data live in subdirectories off of `data`.

## General Approach
The core of the code is the `run_analysis` function in `run_analysis.R`. I structured it to follow the steps given in the project description. It delegates the step actions to helper functions in the same file, located below run_analysis. It also does some additional prep work when needed.

Executing `run_analysis()` in R/Rstudio will work through the various steps in the project description, returning a data frame that satisfies step 5 of the project. (NOTE that a warning message may appear upon completed execution of the function. This will not have impacted the result for step 5.)

Overview of flow of execution:
* read and prep tables for activities and features, loaded from the `data` subdirectory.
* read and merge the training and test datasets from the `train` and `test` subdirectories of `data`. This reads in the corresponding `subject_*.txt`, `X_*.txt`, and `y_*.txt` data files, and column-binds them together in this order. Then row-bind the resulting train and test datasets into the operating source dataset. This gives us a data table with 563 columns and 10299 rows.
* Add the column names to the source dataset, using "SubjectID" for the subject IDs, the feature names from the features table, and "ActivityID" for the activity IDs.
* Create a temporary dataset containing only SubjectID, ActivityID, and features containing mean values ("mean()") and standard deviation values ("std()"). NOTE that there exist other columns that mention mean (e.g. "meanFreq()" and "angle(...)s") but these were not included due to direct interpretation of the request, for simplicity, and for what would be initial review of the findings with stakeholders to gauge if these other columns were needed. This gives us a data table with 68 columns and 10299 rows.
* Using the activities table of names, merge/join the names of activities with their respective ActivityIDs, creating a more descriptive Activity column. Remove the ActivityID column from the dataset as it's no longer needed. This gives us a data table with 68 columns and 10299 rows.
* Tidy the features of this temporary dataset into an intermediary dataset. I attempted to break the grouped features into component variables in accordance with the first premise of tidy data. More information on this can be found in the [Codebook.md] file explaining the approach. More separation could have happened, but I didn't achieve it due to time and current capabilities. SubjectID and Activity columns remained as existing colvars. This gives us a data table with 7 columns and 679734 rows.
* Using the tidy intermediary dataset, I grouped it according to SubjectID (primary) and Activity (secondary), and then summarized the Measurements to get a mean for each Activity for each SubjectID. This is then returned as the result of `run_analysis()`, after ensuring it's converted to a data frame for sharing. This gives us a data frame with 3 columns of 180 rows.
* I then manually used write.table() to export this result to `step5.txt`.
