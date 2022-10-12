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

# install packages
#install.packages("RCurl")
#install.packages("ff")
#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("oligo")

# load libraries
library(oligo)
#library(ff)

# set large data path for ff files
#ldPath()

# target CEL files
celFiles <- list.files(workingDir, full.names=TRUE)

# read CEL files
rawData <- read.celfiles(celFiles)

# RMA normalization
rmaRes <- rma(rawData)

# check out the results
exprs(rmaRes)[1:10,]

# retrieve normalized expression
exprsData  <- exprs(rmaRes)

# save the normalized expression data to a RData file
save(exprsData, file="normalized_RMA.RData")

# write normalized expression to txt file
write.exprs(exprsData, file="normalized_RMA.txt", sep="\t")
