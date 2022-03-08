## Normalization and Batch Effect Removal Pipeline
## Author: Lei Yu 
## Contact: lyu062@ucr.edu

##---------------------------------------------------------------------------------------------
## Section 3: Batch effect removal
##---------------------------------------------------------------------------------------------

## --------------------------------------------------------------------------------------------
## 3.1 Remove batch effects with known batches based on ComBat function. 
## --------------------------------------------------------------------------------------------

# Create batch vector
batch <- c(1,2,3,1,2,3)

# Apply parametric parametric empirical Bayes frameworks adjustment to remove the batch effect
combat_edate_par <- ComBat(dat=TMM, batch=batch, mod=NULL, par.prior=TRUE, prior.plots=F)

# Apply non-parametric empirical Bayes frameworks adjustment to remove the batch effects
combat_edata_non_par <- ComBat(dat= TMM, batch=batch, mod=NULL, par.prior=FALSE, mean.only=TRUE)

# Check out the adjusted expression profiles
head(combat_edate_par)
head(combat_edata_non_par)

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

Batch_Effect_Removal_Result <- list(combat_edate_par <- combat_edate_par,
                                    combat_edata_non_par <- combat_edata_non_par,
                                    combat_seq_with_group <- combat_seq_with_group,
                                    combat_seq_without_group <- combat_seq_without_group,
                                    sva_without_batch_info <- corrected_result
                                      )

print("Step_3 finished, all results are stored in object: Batch_Effect_Removal_Result")
