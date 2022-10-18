#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeOligoRMA_jobOutput
#$ -pe smp 19

# usage: qsub largeOligoRMA_driver.sh workingDir chipType celSet
# usage ex: qsub largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE8888n_4_5_6_CEL
# usage ex: qsub largeOligoRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE88884_CEL

## note (full set)
# Script to run RMA normalization with the aroma.affy R package using a minimum of 19 cores (203GB)
# to use 10 times more RAM than the default settings with the setOption R command

# load the R v4 module
module load R/3.6.2

# set inputs directory
workingDir="$1"

# set chip type
chipType="$2"

# set CEL set
celSet="$3"

# normalize all CEL files
Rscript largeAromaAffy.R $workingDir $chipType $celSet