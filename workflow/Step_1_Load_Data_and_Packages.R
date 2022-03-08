## Title: RNA-Seq Normalization and Batch Effect Removal Pipeline
## Author: Lei Yu 
## Contact: lyu062@ucr.edu


##---------------------------------------------------------------------------------------------
## Section 1:Prepare example dataset and load packages ##
##---------------------------------------------------------------------------------------------

##----------------------------------------------------------------------------------------------
## (Is not necessary to download the data if users downloaded the github Repository. 
## Example dataset is in the input folder.)
# Specify URL where file is stored
# url <- "http://bioinf.wehi.edu.au/edgeR/UserGuideData/arab.rds"
# Specify destination where file should be saved
# destfile <- "../arab.rds"
# Apply download.file function in R
# download.file(url,destfile)
##----------------------------------------------------------------------------------------------

# Import the input r dataset
raw_counts_matrix <- readRDS("./input/arab.rds")

# Check out the import raw counts matrix
head(raw_counts_matrix)

# Load and install packages
# Use the pacman package to load the packages. Pacman can automatically install and load packages. 

library("pacman")
p_load(edgeR, limma, sva, ggplot2, stringr, dplyr, viridis, hrbrthemes, latex2exp, TxDb.Athaliana.BioMart.plantsmart28, ggrepel, ggpubr, reshape2)
