#!/usr/bin/env Rscript

# script to identify set-specific and consensos modules
# usage: Rscript largeAffyRMA.R workingDir
# usage ex: Rscript largeAffyRMA.R /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/GSE8888n_4_5_6

#Retrieve input file name of gene counts
args = commandArgs(trailingOnly=TRUE)

#Set working directory
workingDir = args[1];
#workingDir="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/GSE8888n_4_5_6"
setwd(workingDir)

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("oligo")

library(oligo)
library(ff)
ldPath()

celFiles <- list.celfiles(workingDir, full.names=TRUE)

rawData <- read.celfiles(celFiles)

rmaRes <- rma(rawData)

exprs(rmaRes)[1:10,]
