#!/usr/bin/env Rscript

# R script to retrieve the affymetrix HTA 2.0 array HGNC symbols

# load the biomart library
library("biomaRt")

#Retrieve input file name of gene counts
#args = commandArgs(trailingOnly=TRUE)

#Set working directory
#workingDir = args[1];
workingDir="/Users/bamflappy/GBCF/DxTerity/Data/Annotations"
setwd(workingDir)

# load the human biomart data set
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")

# retrieve all filters
#filters = listFilters(ensembl)

# retrieve all attributes
#attributes = listAttributes(ensembl)

# retrieve mappings for a subset of affy IDs
#affy_ids=c("TC01000001.hg", "TC01000002.hg", "TC01000003.hg")
#getBM(attributes=c('affy_hta_2_0', 'hgnc_id'), 
#      filters = 'affy_hta_2_0', 
#      values = affy_ids, 
#      mart = ensembl)

# retrieve all HTA 2.0 and HGNC mappings
affyList <- getBM(filters= "with_affy_hta_2_0", 
                   attributes= c("affy_hta_2_0", "hgnc_symbol"),
                   values=TRUE,
                   mart= ensembl)

# order the mappings by the HTA 2.0 affy IDs
#affyData <- affyList[order(affyList$affy_hta_2_0),]

# write the mappings to a csv file
write.table(affyList, file="HTA2_0_HGNC_map.csv", sep=",", row.names=FALSE)

