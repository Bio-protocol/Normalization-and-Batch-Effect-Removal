## Normalization and Batch Effect Removal Pipeline
## Author: Lei Yu 
## Contact: lyu062@ucr.edu

##---------------------------------------------------------------------------------------------
## Section 3: Batch effect removal
##---------------------------------------------------------------------------------------------

## --------------------------------------------------------------------------------------------
## 3.1 Remove batch effects with known batches based on ComBat function. 
## --------------------------------------------------------------------------------------------

# If user want to time the script, start the clock!
ptm <- proc.time()

# Create batch vector
batch <- c(1,2,3,1,2,3)

# Apply parametric empirical Bayes frameworks adjustment to remove the batch effect
combat_data_par <- ComBat(dat=TMM, batch=batch, mod=NULL, par.prior=TRUE, prior.plots=F)

# Apply non-parametric empirical Bayes frameworks adjustment to remove the batch effects
combat_data_non_par <- ComBat(dat= TMM, batch=batch, mod=NULL, par.prior=FALSE, mean.only=TRUE)

# Check out the adjusted expression profiles
head(combat_data_par)
# head(combat_edata_non_par)

## --------------------------------------------------------------------------------------------
## 3.2	Remove batch effects with known batches based on ComBat_seq function
## --------------------------------------------------------------------------------------------

# Include group condition 
combat_seq_with_group <- ComBat_seq(raw_counts_matrix, batch=batch, group=group, full_mod=TRUE)

# Do not include group condition 
combat_seq_without_group <- ComBat_seq(raw_counts_matrix, batch=batch, group=NULL, full_mod=FALSE)

# Check out the adjusted expression profiles
head(combat_seq_with_group)
head(combat_seq_without_group)

## --------------------------------------------------------------------------------------------
## 3.3 Remove batch effects with unknown batches based on sva function
## --------------------------------------------------------------------------------------------

df_group <- as.data.frame(group)
rownames(df_group) <- c("mock1","mock2","mock3","hrcc1","hrcc2","hrcc3")
colnames(df_group) <- "Treatment"
mod = model.matrix(~as.factor(Treatment), data=df_group)
mod0 = model.matrix(~1,data=df_group)

sva_result <- sva(TMM,mod,mod0)
names(sva_result)
cov = cbind(sva_result$sv)
corrected_result <- removeBatchEffect(TMM, covariates = cov)
head(round(corrected_result, digits = 3))


# Create a list object to store batch effect removed results
Batch_Effect_Removal_Result <- list(combat_data_par <- combat_data_par,
                                    combat_data_non_par <- combat_data_non_par,
                                    combat_seq_with_group <- combat_seq_with_group,
                                    combat_seq_without_group <- combat_seq_without_group,
                                    sva_without_batch_info <- corrected_result
                                      )

print("Step_3 finished, all results are stored in object: Batch_Effect_Removal_Result")

# End the clock and calculate the script running time.
time <- proc.time() - ptm

## --------------------------------------------------------------------------------------------
## 3.4 Save the batch effect removed files into the output folder
## --------------------------------------------------------------------------------------------

# Save the rds file into the output folder

save(Batch_Effect_Removal_Result, "output/datasets/rds_format/Batch_Effect_Removal_Result.rds")

print("Batch_Effect_Removal_Result is saved in output/datasets/rds_formatBatch_Effect_Removal_Result.rds")

# Also, for users' convenience, we also output the tsv files in the output folder.
# Users can turn the if to "TRUE" to output the tsv files

if(FALSE){
  write.table(Batch_Effect_Removal_Result$combat_data_par, 
              file = "output/datasets/tsv_format/batch_effect_removal/combat_data_par.tsv", 
              row.names=TRUE, 
              col.names = TRUE,
              sep="\t",
              quote = F)
  
  write.table(Batch_Effect_Removal_Result$combat_data_non_par, 
              file = "output/datasets/tsv_format/batch_effect_removal/combat_data_non_par.tsv", 
              row.names=TRUE, 
              col.names = TRUE,
              sep="\t",
              quote = F)
  
  write.table(Batch_Effect_Removal_Result$combat_seq_with_group, 
              file = "output/datasets/tsv_format/batch_effect_removal/combat_seq_with_group.tsv", 
              row.names=TRUE, 
              col.names = TRUE,
              sep="\t",
              quote = F)
  
  write.table(Batch_Effect_Removal_Result$combat_seq_without_group, 
              file = "output/datasets/tsv_format/batch_effect_removal/combat_seq_without_group.tsv", 
              row.names=TRUE, 
              col.names = TRUE,
              sep="\t",
              quote = F)
  
  write.table(Batch_Effect_Removal_Result$sva_without_batch_info, 
              file = "output/datasets/tsv_format/batch_effect_removal/sva_without_batch_info.tsv", 
              row.names=TRUE, 
              col.names = TRUE,
              sep="\t",
              quote = F)
}

## --------------------------------------------------------------------------------------------
## END
## --------------------------------------------------------------------------------------------
