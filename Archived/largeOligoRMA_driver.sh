#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeOligoRMA_jobOutput
#$ -pe smp 8

# usage: qsub largeOligoRMA_driver.sh geoDir
# usage ex: qsub largeOligoRMA_driver.sh GSE8888n_4_5_6
# usage ex: qsub largeOligoRMA_driver.sh GSE88884
# usage ex: qsub largeOligoRMA_driver.sh GSE88885
# usage ex: qsub largeOligoRMA_driver.sh GSE88886

## note (full set)
# Script to run RMA normalization with the oligo R package using a minimum of 16 cores (171GB)
# the raw data is 82GB total, and a vector is created during normalization that is about 162GB
# since each core has 10.7GB RAM available, slightly more than 15 cores are needed for the analysis

# load the R v4 module
module load R/4.2.1

# set input file
inputFile="/scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/"$1"_CEL"

# normalize all CEL files
Rscript largeOligoRMA.R $inputFile
