#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N setupCDF_aromaAffy_jobOutput

# usage: qsub largeAromaAffyRMA_setupCDF.sh workingDir cdfPath outputName chipType
# usage ex: qsub largeAromaAffyRMA_setupCDF.sh /scratch365/ebrooks5 /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/HTA-2_0.r1.gene.cdf HTA-2_0,r1,gene.cdf HTA-2_0
# usage ex: qsub largeAromaAffyRMA_setupCDF.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/HTA-2_0.r1.gene.cdf HTA-2_0,r1,gene.cdf HTA-2_0

# load the R v4 module
module load R/3.6.2

# set working directory
workingDir="$1"

# set input CDF path
cdfPath="$2"

# set output name
outputName="$3"

# set chip type
chipType="$4"

# make sure to make necessary directories
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/annotationData"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/annotationData/chipTypes"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/annotationData/chipTypes/"$chipType

# convert CDF file
Rscript convertCDF_affxparser.R $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/annotationData/chipTypes/"$chipType $cdfPath $outputName
