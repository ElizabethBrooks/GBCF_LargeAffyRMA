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
#install.packages("dplyr", dependencies = TRUE, INSTALL_opts = '--no-lock')
#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("affyPara")

# load libraries
library(affyPara)

AffyBatch <- ReadAffy()

affyBatchBGC <- bgCorrectPara(AffyBatch, method="rma", verbose=TRUE)