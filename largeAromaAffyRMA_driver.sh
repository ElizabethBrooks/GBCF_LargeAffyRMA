#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeAromaAffy_jobOutput
#$ -pe smp 19

# usage: qsub largeAromaAffyRMA_driver.sh workingDir chipType celSet
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy HTA-2_0 GSE8888n_4_5_6_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE88884_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE88885_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy HTA-2_0 GSE88886_CEL
# usage ex: qsub largeAromaAffyRMA_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity_test/rma_aromaAffy HTA-2_0 GSE88886_CEL

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

# setup results directory
mkdir $workingDir"/results"

# normalize all CEL files
Rscript largeAromaAffyRMA.R $workingDir $chipType $celSet

# move to results directory
cd $workingDir"/results"

# retrieve row names
linearData="normalizedLinear_RMA_"$celSet".csv"
tmpLinear="tmp_normalizedLinear_RMA_"$celSet".csv"
cut -d "," -f 1 $linearData > $tmpLinear

# add row names to the log transformed data file
logData="normalizedLogTransformed_RMA_"$celSet".csv"
tmpLog="tmp_normalizedLogTransformed_RMA_"$celSet".csv"
paste -d , $tmpLinear $logData > $tmpLog
mv $tmpLog $logData

# clean up
rm $tmpLinear
rm $tmpLog
