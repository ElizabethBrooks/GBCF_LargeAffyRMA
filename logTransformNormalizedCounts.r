#!/usr/bin/env Rscript

# script to log transform RMA normalized older affymetrix array data
# usage: Rscript logTransformNormalizedCounts.r workingDir celSet
# usage ex: Rscript logTransformNormalizedCounts.r /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy GSE8888n_4_5_6_CEL

# retrieve input file name of gene counts
args = commandArgs(trailingOnly=TRUE)

# set working directory
workingDir = args[1];
#workingDir="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy"
setwd(workingDir)

# load libraries
library(ggplot2)
library(dplyr)

# turn off scientific notation
options(scipen = 999)

# define CEL set
celSet <- args[3]
#celSet <- "GSE8888n_4_5_6_CEL"

# import normalized data
importFile <- paste("results/normalizedLinear_RMA", celSet, sep="_")
importFile <- paste(importFile, "csv", sep=".")
inputCounts <- read.csv(file=importFile)

# set output file name
exportFile <- paste("results/normalizedLog_RMA", celSet, sep="_")
exportFile <- paste(exportFile, "csv", sep=".")

# perform log transformations of log2(x+1)
outputCounts <- inputCounts
for(i in 2:ncol(inputCounts)) {
  outputCounts[,i] <- log2(inputCounts[,i]+1)
}

# write log transformed counts to a file
write.csv(outputCounts, file=exportFile)
