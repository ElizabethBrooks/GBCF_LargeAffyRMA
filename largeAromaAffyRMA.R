#!/usr/bin/env Rscript

# script to RMA normalize newer affymetrix array data
# usage: Rscript largeAromaAffyRMA.R workingDir chipType celSet
# usage ex: Rscript largeAromaAffyRMA.R /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy HTA-2_0 GSE8888n_4_5_6_CEL

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
future::plan("multicore")
#future::plan("multisession")

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
#print(cdf)

# define CEL set
celSet <- args[3]
#celSet <- "GSE8888n_4_5_6_CEL"
cs <- AffymetrixCelSet$byName(celSet, cdf=cdf)
#print(cs)

# background adjustment and normalization
bc <- RmaBackgroundCorrection(cs)
csBC <- process(bc,verbose=verbose)

# setup a quantile normalization method
qn <- QuantileNormalization(csBC, typesToUpdate="pm")
print(qn)

# run quantile normalization
csN <- process(qn, verbose=verbose)
#print(csN)

# fit the RMA probe level model (PLM)
plm <- RmaPlm(csN)
#print(plm)

# actually fit the PLM to all of the data
fit(plm, verbose=verbose)

# extract the estimates
ces <- getChipEffectSet(plm)

# create a data frame of intensity values
gExprs <- extractDataFrame(ces, addNames=TRUE)
#head(gExprs)
#head(rownames(gExprs))
#head(colnames(gExprs))

# save the normalized linear expression data to a RData file
exportFile <- paste("results/normalizedLinear_RMA", celSet, sep="_")
exportFile <- paste(exportFile, "RData", sep=".")
save(gExprs, file=exportFile)

# write normalized linear expression to csv file
exportFile <- paste("results/normalizedLinear_RMA", celSet, sep="_")
exportFile <- paste(exportFile, "csv", sep=".")
write.csv(gExprs, file=exportFile, row.names=FALSE)

# examine NUSE and RLE plots
qam <- QualityAssessmentModel(plm)
# NUSE
exportFile <- paste("results/plmFit_NUSE_RMA", celSet, sep="_")
exportFile <- paste(exportFile, "pdf", sep=".")
pdf(file=exportFile)
plotNuse(qam)
dev.off()

# RLE
exportFile <- paste("results/plmFit_RLE_RMA", celSet, sep="_")
exportFile <- paste(exportFile, "pdf", sep=".")
pdf(file=exportFile)
plotRle(qam)
dev.off()

# create a matrix of intensity values
gExprsMatrix <- extractMatrix(ces)

# perform log transformation
gExprsMatrixLog <- log2(gExprsMatrix)

# convert to a data frame
gExprsLog <- as.data.frame(gExprsMatrixLog)
rownames(gExprsLog) <- rownames(gExprs)
colnames(gExprsLog) <- colnames(gExprs)

# write normalized log transformed expression to csv file
exportFile <- paste("results/normalizedLogTransformed_RMA", celSet, sep="_")
exportFile <- paste(exportFile, "csv", sep=".")
write.csv(gExprsLog, file=exportFile, row.names=FALSE)
