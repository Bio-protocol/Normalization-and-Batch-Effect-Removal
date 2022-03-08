## Title: RNA-Seq Normalization and Batch Effect Removal Pipeline
## Author: Lei Yu 
## Contact: lyu062@ucr.edu


##---------------------------------------------------------------------------------------------
## Section 2: Normalization
##---------------------------------------------------------------------------------------------

# If user want to time the script, start the clock!
ptm <- proc.time()

# Create group vector
group <- c('mock','mock','mock','hrcc','hrcc','hrcc')

# Create DEGList object
DEGL <- DGEList(counts=raw_counts_matrix, group=group)
# Checkt out DEGList object
DEGL

## --------------------------------------------------------------------------------------------
## 2.1 CPM normnalization 
## --------------------------------------------------------------------------------------------
# Calculate normalization factors to align columns of a count matrix
DEGL_cpm <- calcNormFactors(DEGL, method = "none")

# Calculate the cpm
cpm <- cpm(DEGL_cpm, log = FALSE, normalized.lib.sizes=TRUE)

# Calculate the log cpm
LOG_cpm <- cpm(DEGL_cpm, log = TRUE, normalized.lib.sizes=TRUE)

# Check out the cpm normalized matrix and log cpm normalized matrix
head(cpm)
head(LOG_cpm)

## --------------------------------------------------------------------------------------------
## 2.2 RPKM normalization
## --------------------------------------------------------------------------------------------

# Download the TxDb and import the database into R
TxDb <- TxDb.Athaliana.BioMart.plantsmart28

# Check out the reference gene database
head(genes(TxDb))

# Subtract the gene length information from TxDb.Athaliana.BioMart.plantsmart28
ref_gene_length <- as.data.frame(genes(TxDb))["width"]

# Delete the genes that in raw counts matrix without length information in reference
raw_counts_matrix <- raw_counts_matrix[intersect(rownames(raw_counts_matrix), rownames(ref_gene_length)),]

gene_length <- ref_gene_length[rownames(raw_counts_matrix),]

# Create a DEGList with the gene length information
DEGL_with_gene_length <- DGEList(counts=raw_counts_matrix, group=group, genes=data.frame(Length=gene_length))

# Check out the DEGList with gene length information 
DEGL_with_gene_length

# Calculate normalization factors to align columns of a count matrix
DEGL_with_gene_length_rpkm <- calcNormFactors(DEGL_with_gene_length)

# Calculate RPKM normalization 
RPKM <- rpkm(DEGL_with_gene_length_rpkm)

# Check out the RPKM normalized matrix 
head(RPKM)

LOG_RPKM <- log(RPKM+0.25)

## --------------------------------------------------------------------------------------------
## 2.4 TPM normalization
## --------------------------------------------------------------------------------------------
# Input: RPKM normalized matrix
# Output: TPM normalizaed matrix 

source("./lib/rpkm_to_tpm.R")
TPM <- rpkm_to_tpm(RPKM)
LOG_TPM <- log(TPM+0.25)

# Check out the TPM normalization result 
head(TPM)
head(LOG_TPM)


## --------------------------------------------------------------------------------------------
## 2.5 TMM normalization
## --------------------------------------------------------------------------------------------
DEGL_TMM <- calcNormFactors(DEGL, method="TMM")
TMM <- cpm(DEGL_TMM, log = F, normalized.lib.sizes=TRUE)
LOG_TMM <- cpm(DEGL_TMM, log = T, normalized.lib.sizes=TRUE)

# Check out the TMM normalized result 
head(TMM)
head(LOG_TMM)

## --------------------------------------------------------------------------------------------
## 2.6 RLE normalization
## --------------------------------------------------------------------------------------------
# Calculate normalization factors using RLE method to align columns of a count matrix
DEGL_RLE <- calcNormFactors(DEGL, method="RLE")

# Calculate the cpm with the RLE normalized library
RLE <- cpm(DEGL_RLE, log =F, normalized.lib.sizes=TRUE)
LOG_RLE <- cpm(DEGL_RLE, log =T, normalized.lib.sizes=TRUE)

# Check out the RLE normalized result 
head(RLE)
head(LOG_RLE)

## --------------------------------------------------------------------------------------------
## 2.7 RLE normalization
## --------------------------------------------------------------------------------------------
# Calculate normalization factors using UQ method to align columns of a count matrix
DEGL_UQ <- calcNormFactors(DEGL, method="upperquartile")

# Calculate the cpm with the UQ normalized library
UQ <- cpm(DEGL_UQ, log = F, normalized.lib.sizes=TRUE)
LOG_UQ <- cpm(DEGL_UQ, log = T, normalized.lib.sizes=TRUE)
# Check out the UQ normalized result 
head(UQ)
head(LOG_UQ)

Normalization_Result <- list(cpm = cpm,
                             LOG_cpm = LOG_cpm,
                             RPKM = RPKM,
                             LOG_RPKM = LOG_RPKM,
                             TPM = TPM,
                             LOG_TMM = LOG_TMM,
                             RLE = RLE,
                             LOG_RLE = LOG_RLE,
                             UQ = UQ,
                             LOG_UQ = LOG_UQ)

print("Step_2 finished, all results are stored in object: Normalization_Result")

# End the clock and calculate the script running time.
time <- proc.time() - ptm

