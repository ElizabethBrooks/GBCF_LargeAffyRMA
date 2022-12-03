#!/bin/bash

# BASH script to subset columns of normalized data

# load necessary software
module load bio

# set working directory
workingDir="/afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results"

# define CEL set
celSet <- "GSE8888n_4_5_6_CEL"

# set the number of samples
#numSamples=3146

# set the number of columns
numCols=3152

# move to the data directory
cd $workingDir

# loop over each column for each sample
# the first 6 columns are summary data
for i in $(seq 7 $numCols); do
	# retrieve the sample column data
	cut -d "," -f $i normalizedLinear_RMA_$celSet.csv > normalizedLinear_RMA_$celSet_col$i.csv
	# perform log2 transformation of the column
	Rscript logTransformNormalizedCounts.r $workingDir $celSet col$i
done

# add summary data to the transformed data file
cut -d , -f 1-6 normalizedLinear_RMA_$celSet.csv > normalizedLog_RMA_$celSet.csv

# loop over each transformed column file for each sample and paste into one file
for i in $(seq 7 $numCols); do
	paste -d , normalizedLog_RMA_$celSet.csv normalizedLog_RMA_$celSet_col$i.csv
done

# clean up
rm normalizedLinear_RMA_$celSet_col*.csv
rm normalizedLog_RMA_$celSet_col*.csv
