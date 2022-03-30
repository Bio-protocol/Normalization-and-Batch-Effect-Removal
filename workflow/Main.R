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

## Step 3
source("workflow/Step_3_Batch_Effect_Removal.R")

## Step 4: Results visualization

## Visualization of Normalized results
source("workflow/Plot_Normalization_Violin_Plot.R")
violin_box_plots_cpm
## Visualization of Batch Effect removed results
source("workflow/Plot_PCA_Clustering_Distribution_After_Batch_Effect_Removal.R")
ggarrange(p_raw, p_TMM, p_combat_edate_par, p_combat_edata_non_par, p_combat_seq_with_group, p_combat_seq_without_group,
          labels = c("A", "B", "C", "D", "E", "F"),
          ncol = 2, nrow = 3)
