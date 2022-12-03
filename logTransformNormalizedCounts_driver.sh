#!/bin/bash

# BASH script to subset columns of normalized data

# usage: qsub largeAromaAffyRMA_driver.sh workingDir celSet
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results GSE8888n_4_5_6_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy/results GSE88884_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy/results GSE88885_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy/results GSE88886_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity_test/rma_aromaAffy/results GSE88886_CEL


# load necessary software
module load bio

# set working directory
workingDir="$1"
#workingDir="/afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results"

# define CEL set
celSet="$2"
#celSet="GSE8888n_4_5_6_CEL"

# set the number of columns
numCols=$(($(head -1 $workingDir/normalizedLinear_RMA_$celSet.csv | sed 's/,/,\n/g' | grep "," | wc -l)+1))

# loop over each column for each sample
# the first 6 columns are summary data
for i in $(seq 7 $numCols); do
	# retrieve the sample column data
	cut -d "," -f $i $workingDir/normalizedLinear_RMA_$celSet.csv > $workingDir/normalizedLinear_RMA_$celSet_col$i.csv
	# perform log2 transformation of the column
	Rscript logTransformNormalizedCounts.r $workingDir $celSet col$i
done

# add summary data to the transformed data file
cut -d , -f 1-6 $workingDir/normalizedLinear_RMA_$celSet.csv > $workingDir/normalizedLog_RMA_$celSet.csv

# loop over each transformed column file for each sample and paste into one file
for i in $(seq 7 $numCols); do
	paste -d , $workingDir/normalizedLog_RMA_$celSet.csv $workingDir/normalizedLog_RMA_$celSet_col$i.csv
	# clean up
	rm $workingDir/normalizedLinear_RMA_$celSet_col$i.csv
	rm $workingDir/normalizedLog_RMA_$celSet_col$i.csv
done