## Normalization and Batch Effect Removal Pipeline
## Author: Lei Yu 
## Contact: lyu062@ucr.edu

##---------------------------------------------------------------------------------------------
## Main Script
##---------------------------------------------------------------------------------------------

## Step 1
source("workflow/Step_1_Load_Data_and_Packages.R")

## Step 2
source("workflow/Step_2_Different_Normalization_Methods.R")

## Visualization of Normalized results
source("workflow/Plot_Normalization_Violin_Plot.R")
violin_box_plots_cpm


