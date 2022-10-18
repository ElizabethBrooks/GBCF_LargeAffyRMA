#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N setupAromaAffy_CEL_jobOutput

# usage: qsub largeAromaAffyRMA_setupCEL.sh workingDir celPath celDir chipType
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /scratch365/ebrooks5 /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE8888n_4_5_6_CEL HTA-2_0
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88884_CEL HTA-2_0
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88885_CEL HTA-2_0
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88886_CEL HTA-2_0

# set working directory
workingDir="$1"

# set input CEL path
celPath="$2"

# set input CEL directory
celDir="$3"

# set chip type
chipType="$4"

# make sure to make necessary directories
mkdir $workingDir"/GBCF_bioinformatics_DxTerity"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/$celDir"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/$celDir/$chipType"

# make sure to move CEL files
mv $celPath"/"$celDir"/"*".CEL.gz" $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/$celDir/$chipType"

# unzip the gz CEL files
gunzip $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/"$celDir"/"$chipType"/"*".gz"
