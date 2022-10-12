#!/usr/bin/env Rscript

# script to RMA normalize newer affymetrix array data
# usage: Rscript largeOligoRMA_interactive.R
# first, make sure to request 16 cores using the following ND CRC server shell command
# qrsh -pe smp 16
# also, be sure to load the R v4 module using the following ND CRC server shell command
# module load R/4.2.1

# Windows systems
#Sys.getenv('R_MAX_VSIZE')
#Sys.setenv('R_MAX_VSIZE'=171GB)

#Set working directory
#workingDir = args[1];
workingDir="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/GSE8888n_4_5_6"
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
#celFiles="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/GSE8888n_4_5_6/GSM2350873_A52084400939561101515421438861513.CEL.gz"
rawData <- read.celfiles(celFiles)

# RMA normalization
rmaRes <- rma(rawData)

# look at the first 10 results
exprs(rmaRes)[1:10,]

# retrieve normalized expression set
exprsData  <- exprs(rmaRes)

# save the normalized expression data to a RData file
#save(exprsData, file="test_normalized_RMA.RData")
save(exprsData, file="normalized_RMA.RData")

# write normalized expression to txt file
#capture.output(exprsData, file="test_normalized_RMA.txt")
capture.output(exprsData, file="normalized_RMA.txt")

