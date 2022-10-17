#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeOligoRMA_jobOutput

# usage: qsub largeOligoRMA_driver.sh inputDir chipType celSet
# usage ex: qsub largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE8888n_4_5_6_CEL

## note (full set)
# Script to run RMA normalization with the oligo R package using a minimum of 16 cores (171GB)
# the raw data is 82GB total, and a vector is created during normalization that is about 162GB
# since each core has 10.7GB RAM available, slightly more than 15 cores are needed for the analysis

# load the R v4 module
module load R/3.6.2

# set inputs directory
inputDir="$1"

# set chip type
chipType="$2"

# set CEL set
celSet="$3"

# normalize all CEL files
Rscript largeAromaAffy.R $inputDir $chipType $celSet
