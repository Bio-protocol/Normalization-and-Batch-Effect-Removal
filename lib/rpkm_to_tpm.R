# Self define function to calcualte tpm from rpkm 
# Input: RPKM normalized matrix
# Output: TPM normalizaed matrix 

rpkm_to_tpm <- function(x) {
  rpkm.sum <- colSums(x)
  return(t(t(x) / (1e-06 * rpkm.sum)))
}