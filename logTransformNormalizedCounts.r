#!/usr/bin/env Rscript

# script to log transform RMA normalized older affymetrix array data
# usage: Rscript logTransformNormalizedCounts.r workingDir celSet columnName
# usage ex: Rscript logTransformNormalizedCounts.r /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy GSE8888n_4_5_6_CEL col1

# retrieve input file name of gene counts
args = commandArgs(trailingOnly=TRUE)

# set working directory
workingDir = args[1];
#workingDir="/afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results"
setwd(workingDir)

# load libraries
library(ggplot2)
library(dplyr)

# turn off scientific notation
options(scipen = 999)

# define CEL set
celSet <- args[2]
#celSet <- "GSE8888n_4_5_6_CEL"

# retrieve input column name
colName <- args[3]
#colName <- "col1"

# import normalized data
importFile <- paste("normalizedLinear_RMA", celSet, sep="_")
importFile <- paste(importFile, colName, sep="_")
importFile <- paste(importFile, "csv", sep=".")

# retrieve input counts
inputCounts <- read.csv(file=importFile)

# set output file name
exportFile <- paste("normalizedLog_RMA", celSet, sep="_")
exportFile <- paste(exportFile, colName, sep="_")
exportFile <- paste(exportFile, "csv", sep=".")

# perform log transformations of log2(x+1)
outputCounts <- log2(inputCounts+1)

# write log transformed counts to a file
write.csv(outputCounts, file=exportFile)
