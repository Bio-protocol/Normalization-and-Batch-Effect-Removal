### Violin & Boxplot ###

## Melt log raw cpm
melt_log_cpm <- melt(LOG_cpm)
colnames(melt_log_cpm) <- c("Gene", "Replicates", "Logcpm")

melt_log_cpm$Group <- substr(melt_log_cpm$Replicates,1,nchar(as.character(melt_log_cpm$Replicates))-1)
melt_log_cpm$Normalization <- "Raw" 

## Melt log TMM
melt_log_TMM_cpm <- melt(LOG_TMM)
colnames(melt_log_TMM_cpm) <- c("Gene", "Replicates", "Logcpm")

melt_log_TMM_cpm$Group <- substr(melt_log_TMM_cpm$Replicates,1,nchar(as.character(melt_log_TMM_cpm$Replicates))-1)
melt_log_TMM_cpm$Normalization <- "TMM Normalization" 

## Melt log RLE
melt_log_RLE_cpm <- melt(LOG_RLE)
colnames(melt_log_RLE_cpm) <- c("Gene", "Replicates", "Logcpm")

melt_log_RLE_cpm$Group <- substr(melt_log_RLE_cpm$Replicates,1,nchar(as.character(melt_log_RLE_cpm$Replicates))-1)
melt_log_RLE_cpm$Normalization <- "RLE Normalization" 

## Melt log UQ
melt_log_UQ_cpm <- melt(LOG_UQ)
colnames(melt_log_UQ_cpm) <- c("Gene", "Replicates", "Logcpm")

melt_log_UQ_cpm$Group <- substr(melt_log_UQ_cpm$Replicates,1,nchar(as.character(melt_log_UQ_cpm$Replicates))-1)
melt_log_UQ_cpm$Normalization <- "UQ Normalization" 


## Melt log RPKM 
melt_log_RPKM_cpm <- melt(LOG_RPKM)
colnames(melt_log_RPKM_cpm) <- c("Gene", "Replicates", "Logcpm")

melt_log_RPKM_cpm$Group <- substr(melt_log_RPKM_cpm$Replicates,1,nchar(as.character(melt_log_RPKM_cpm$Replicates))-1)
melt_log_RPKM_cpm$Normalization <- "RPKM Normalization" 

## Melt log TPM
melt_log_TPM_cpm <- melt(LOG_TPM)
colnames(melt_log_TPM_cpm) <- c("Gene", "Replicates", "Logcpm")

melt_log_TPM_cpm$Group <- substr(melt_log_TPM_cpm$Replicates,1,nchar(as.character(melt_log_TPM_cpm$Replicates))-1)
melt_log_TPM_cpm$Normalization <- "TPM Normalization" 

normalization_boxplot_df <- bind_rows(melt_log_cpm, melt_log_TMM_cpm, melt_log_RLE_cpm, melt_log_UQ_cpm,
                                      melt_log_RPKM_cpm, melt_log_TPM_cpm)

dodge <- position_dodge(width = 0.8)
violin_box_plots_cpm <- ggplot(normalization_boxplot_df, aes(x=Group, y=Logcpm, fill = Replicates)) + 
  geom_violin(position = dodge) +
  geom_boxplot(width=0.1, color="black", alpha=0.8, position = dodge) +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  theme_bw()+ 
  theme(
    legend.text=element_text(size=18,face="bold"),
    legend.title =element_text(size=18, face="bold"),
    strip.text = element_text(size=18, face="bold"),
    axis.text=element_text(size=20,face="bold"),
    axis.title=element_text(size=20)
  ) +
  ggtitle("") +
  xlab("Group") +
  ylab(TeX("$Log_2(CPM)$"))+
  facet_wrap(~Normalization,  ncol=2)

violin_box_plots_cpm

