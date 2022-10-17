#!/usr/bin/env Rscript

# script to RMA normalize newer affymetrix array data
# usage: Rscript largeOligoRMA.R workingDir chipType celSet
# usage ex: Rscript largeOligoRMA.R /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE8888n_4_5_6_CEL

# retrieve input file name of gene counts
args = commandArgs(trailingOnly=TRUE)

#Set working directory
workingDir = args[1]
#workingDir="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy"
setwd(workingDir)

# install packages
#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("aroma.affymetrix")
#BiocManager::install("affy")

# load libraries
library(aroma.affymetrix)

# parallel processing
future::plan("multiprocess")

# job scheduler processing
#future::plan(future.batchtools::batchtools_torque)

# Use 10 times more RAM than the default settings
setOption(aromaSettings, "memory/ram", 200.0)

# retrieve verbose info
verbose <- Arguments$getVerbose(-8, timestamp=TRUE)

# retrieve annotation data
chipType <- args[2]
#chipType <- "HTA-2_0"
cdf <- AffymetrixCdfFile$byChipType(chipType, tags=c("r1", "gene"))
print(cdf)

# define CEL set
celSet <- args[3]
#celSet <- "GSE8888n_4_5_6_CEL"
cs <- AffymetrixCelSet$byName(celSet, cdf=cdf)
print(cs)

# background adjustment and normalization
bc <- RmaBackgroundCorrection(cs)
csBC <- process(bc,verbose=verbose)

# setup a quantile normalization method
qn <- QuantileNormalization(csBC, typesToUpdate="pm")
print(qn)

# run quantile normalization
csN <- process(qn, verbose=verbose)
print(csN)

# fit the RMA probe level model (PLM)
plm <- RmaPlm(csN)
print(plm)

# extract the estimates
ces <- getChipEffectSet(plm)
gExprs <- extractDataFrame(ces, units=1:3, addNames=TRUE)

# save the normalized linear expression data to a RData file
save(gExprs, file="normalizedLinear_RMA.RData")

# write normalized linear expression to txt file
capture.output(gExprs, file="normalizedLinear_RMA.txt")

# examine NUSE and RLE plots
qam <- QualityAssessmentModel(plm)
# NUSE
pdf(file="plmFit_NUSE_RMA.pdf")
plotNuse(qam)
dev.off()
# RLE
pdf(file="plmFit_RLE_RMA.pdf")
plotRle(qam)
dev.off()
