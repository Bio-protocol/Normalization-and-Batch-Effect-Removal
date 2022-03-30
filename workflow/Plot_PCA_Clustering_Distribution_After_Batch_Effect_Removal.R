### PCA plot 

pca_plot <- function(input, title){
  set.seed(42)
  input_pca <- prcomp(t(input))
  input_pca_out <- as.data.frame(input_pca$x)
  input_pca_out$Treat <- str_extract(rownames(input_pca_out), "[a-z]{1,4}")
  percentage <- round(input_pca$sdev / sum(input_pca$sdev) * 100, 2)
  percentage <- paste(colnames(input_pca_out), "(", paste( as.character(percentage), "%", ")", sep=""))
  p <- ggplot(input_pca_out,aes(x=PC1,y=PC2, color = Treat)) + geom_point() + 
    geom_label_repel(aes(label = rownames(input_pca_out), 
                         fill = Treat), 
                     color = 'white', size = 4,
                     box.padding = unit(0.35, "lines"),
                     point.padding = unit(0.3, "lines")) +
    theme_bw() + 
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      legend.text=element_text(size=12,face="bold"),
      legend.title =element_text(size=12, face="bold"),
      strip.text = element_text(size=12, face="bold"),
      axis.text=element_text(size=12,face="bold"),
      axis.title=element_text(size=12),
      plot.title = element_text(size=12, face="bold")
    ) + 
    xlim(-40000, 80000) +
    ylim(-50000, 60000) +
    xlab(percentage[1]) + 
    ylab(percentage[2]) +
    ggtitle(title) +
    theme(legend.position = "none")
  return(p)
}


p_raw <- pca_plot(cpm, "PCA plot based on raw cpm")
p_TMM <- pca_plot(TMM, "PCA plot based on TMM cpm")
p_combat_data_par <- pca_plot(combat_data_par, "PCA plot based on combat_data_par")
p_combat_data_non_par <- pca_plot(combat_data_non_par, "PCA plot based on combat_data_non_par")
p_combat_seq_with_group <- pca_plot(combat_seq_with_group, "PCA plot based on p_combat_seq_with_group")
p_combat_seq_without_group <- pca_plot(combat_seq_without_group, "PCA plot based on combat_seq_without_group")

## Save the figure into output folder

png(file = "./output/figures/PCA_Plot_of_Batch_Effect_Removed_Results.png",   # The directory you want to save the file in
    width = 800, # The width of the plot in inches
    height = 800) # The height of the plot in inches
ggarrange(p_raw, p_TMM, p_combat_data_par, p_combat_data_non_par, p_combat_seq_with_group, p_combat_seq_without_group,
          labels = c("A", "B", "C", "D", "E", "F"),
          ncol = 2, nrow = 3)
dev.off()
