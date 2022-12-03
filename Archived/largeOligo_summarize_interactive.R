#!/usr/bin/env Rscript

# script to RMA normalize newer affymetrix array data
# usage: Rscript largeOligo_summarize_interactive.R

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

# retrieve loaded expression values
exprsData <- exprs(rawData)

# verify it is raw intensity data (e.g., max value of 65,536)
maxExprs <- max(exprs(rawData))

# write expression to txt file
capture.output(maxExprs, file="maxExpression.txt")

# save the expression data to a RData file
#save(exprsData, file="test_expression.RData")
save(exprsData, file="expression.RData")

# write expression to txt file
#capture.output(exprsData, file="test_expression.txt")
capture.output(exprsData, file="expression.txt")
