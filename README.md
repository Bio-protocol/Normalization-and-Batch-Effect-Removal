# Transformation, Normalization and Batch Effect Removal
## Introduction 
In bulk RNA-seq analysis, normalization and batch effect removal are two necessary procedures to scale the read counts and reduce the technical errors. Many differential expression analysis tools require raw count matrix as input and embed the normalization and batch effect removal procedures in the analysis pipeline, but researchers need to perform these two procedures independently when they build up their own bulk RNA profile analysis models. This protocol includes detailed codes and explanations of normalization and batch effect removal, which can help users understand and perform procedures more conveniently. We use the easily obtainable public Arabidopsis thaliana bulk RNA-seq dataset in the case study and researchers interested in this topic can use this protocol to learn and apply. 

**If users are interested in differential expression analysis, most of the DEG pipelines are requiring raw RNA counts matrix as input. This Chapter is more suitable for the users intended to developing their own pipeline or models which need to normalize the data and remove batch effects from raw counts**

To guide eBook authors having a better sense of the workflow layout, here we briefly introduce the specific purposes of the dir system. 

1. __cache__: Here, it stores the intermediate results. 
2. __graphs__: The graphs/figures produced during the analysis.
3. __input__: Here, we provide the example input dataset. 
4. __lib__: The source code, functions, or algorithms used within the workflow.
5. __output__: The final output results of the workflow.
6. __workflow__: Step by step pipeline for normalization and batch effect removal.

## Overview of an example workflow: Normalization and batch effect removal 

Based on the raw RNA count dataset, we perform the normalization at first to remove the library size difference between arrays then apply batch effect removal procedure to reduce the batch effect. 

![Normalization and batch effect removal workflow](graphs/Workflow.png)

## Installation

- __Running environment__: 
    R version 4.1.1 (2021-08-10)

- __Required R Packages__: 
  - __Dataset__:
    [TxDb.Athaliana.BioMart.plantsmart28 (3.2.2)](https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart28.html)
   - __Normalization__:
      [edgeR (3.34.0)](https://bioconductor.org/packages/release/bioc/html/edgeR.html), [limma (3.48.0)](https://bioconductor.org/packages/release/bioc/html/limma.html)
    - __Batch Effect Removal__:
      [sva (3.40.0)](https://bioconductor.org/packages/release/bioc/html/sva.html)

  - __Data Manipulation & Visualization__:
      [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html), [stringr](https://cran.r-project.org/web/packages/stringr/index.html), [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html), [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html), [viridis](https://cran.r-project.org/web/packages/viridis/index.html), [ggpubr](https://cran.r-project.org/web/packages/ggpubr/index.html), [hrbrthemes](https://cran.r-project.org/web/packages/hrbrthemes/index.html), [latex2exp](https://cran.r-project.org/web/packages/latex2exp/index.html)
       
## Input Data
To demonstrate different normalization methods and batch effect removal methods, we use the Arabidopsis thaliana RNA count data published by [Cumbie et al.](https://www.google.com/search?q=4.%09Cumbie%2C+J.+S.%2C+Kimbrel%2C+J.+A.%2C+Di%2C+Y.%2C+Schafer%2C+D.+W.%2C+Wilhelm%2C+L.+J.%2C+Fox%2C+S.+E.%2C+Sullivan%2C+C.+M.%2C+Curzon%2C+A.+D.%2C+Carrington%2C+J.+C.%2C+Mockler%2C+T.+C.+and+Chang%2C+J.+H.+%282011%29.+GENE-counter%3A+a+computational+pipeline+for+the+analysis+of+RNA-Seq+data+for+gene+expression+differences.+PLoS+One+6%2810%29%3A+e25279.&rlz=1C1CHBF_enUS890US890&ei=BhoIYrL1IJWgkPIP1LeMqA0&ved=0ahUKEwiykPn4gfv1AhUVEEQIHdQbA9UQ4dUDCA4&uact=5&oq=4.%09Cumbie%2C+J.+S.%2C+Kimbrel%2C+J.+A.%2C+Di%2C+Y.%2C+Schafer%2C+D.+W.%2C+Wilhelm%2C+L.+J.%2C+Fox%2C+S.+E.%2C+Sullivan%2C+C.+M.%2C+Curzon%2C+A.+D.%2C+Carrington%2C+J.+C.%2C+Mockler%2C+T.+C.+and+Chang%2C+J.+H.+%282011%29.+GENE-counter%3A+a+computational+pipeline+for+the+analysis+of+RNA-Seq+data+for+gene+expression+differences.+PLoS+One+6%2810%29%3A+e25279.&gs_lcp=Cgdnd3Mtd2l6EAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsAMyBwgAEEcQsANKBAhBGABKBAhGGABQwQNYwQNgvAloAnABeACAAQCIAQCSAQCYAQCgAQKgAQHIAQjAAQE&sclient=gws-wiz) as an example. Users can use the data in the **input** folder. 
For the users want to download the dataset by themselves, the following R scripts can be used. 
```
##----------------------------------------------------------------------------------------------
## (Is not necessary to download the data if users downloaded the github Repository. 
## Example dataset is in the input folder.)
# Specify URL where file is stored
# url <- "http://bioinf.wehi.edu.au/edgeR/UserGuideData/arab.rds"
# Specify destination where file should be saved
# destfile <- "../arab.rds"
# Apply download.file function in R
# download.file(url,destfile)

```


## Major steps
Under R or RStudio environment (R Version > 4.1.1), set working environment to `/path/to/Normalization-and-Batch-Effect-Removal/` 

```
setwd("/path/to/Normalization-and-Batch-Effect-Removal/"")
```

then source the scripts step by step (or directly use the `workflow/main.R` script). 

#### Step 1: Load the data and packages

```
source("workflow/Step_1_Load_Data_and_Packages.R")
```

#### Step 2: Normalize the raw count matrix based on different methods

```
source("workflow/Step_2_Different_Normalization_Methods.R")
```

#### Step 3: Remove batch effect based on normalized data

```
source("workflow/Step_3_Batch_Effect_Removal.R")
```



## Expected results
**Violin & Box plot of Normalized Expression**
![Violin_Boxplot_of_Normalized_Expression](graphs/Violin_Boxplot_of_Normalized_Expression.png)

**PC1 and PC2 plot based on different batch removal methods comparing with TMM normalized CPM and raw CPM**
![PCA](graphs/PCA_Plot_of_Batch_Effect_Removed_Results.png)

## License
It is a free and open source software, licensed under [MIT](https://github.com/github/choosealicense.com/blob/gh-pages/LICENSE.md).
