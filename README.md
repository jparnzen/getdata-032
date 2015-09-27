# README for Course Project
Quick notes and explanations on my approach to solving our assigned course project.

## Libraries Used
* data.table: provides fast reading of data files into an optimized and efficient data table structure, with a similar set of actions and behaviors to base R data frames.
* tidyr: provides functions for actions frequently performed when tidying data (separating and gathering data variables)
* dplyr: provides fast and database-like operations on data tables and data frames (selecting, grouping, and summarizing)

## Assumptions
Some assumptions are documented in the comments for my code.

## General Approach
The core of the code is the run_analysis function in run_analysis.R. I structured it to follow the steps given in the project description. It delegates the step actions to helper functions in the same file, located below run_analysis. It also does some additional prep work when needed.

