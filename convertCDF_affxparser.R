#!/usr/bin/env Rscript

# script to RMA normalize newer affymetrix array data
# usage: Rscript largeOligoRMA.R workingDir cdfFile outputName
# usage ex: Rscript largeOligoRMA.R /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy/annotationData/chipTypes/HTA-2_0/ /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/HTA-2_0.r1.gene.cdf HTA-2_0,r1,gene.cdf

# retrieve input file name of gene counts
args = commandArgs(trailingOnly=TRUE)

#Set working directory
workingDir = args[1]
#workingDir="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy/annotationData/chipTypes/HTA-2_0/"
setwd(workingDir)

# install packages
#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("affxparser")

# load libraries
library(affxparser)

# retrieve annotation data
cdfFile <- args[2]
#cdfFile <- "/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/HTA-2_0.r1.gene.cdf"

# set output name
outputName <- args[3]
#outputName <- "HTA-2_0,r1,gene.cdf"

# convert ASCII CDF to binary/XDA
convertCdf(cdfFile, outputName)
