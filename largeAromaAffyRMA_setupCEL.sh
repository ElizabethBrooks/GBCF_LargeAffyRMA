#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N setupAromaAffy_CEL_jobOutput

# usage: qsub largeAromaAffyRMA_setupCEL.sh workingDir celDir 
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/PLAGUIES /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE8888n_4_5_6_CEL
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88884_CEL
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88885_CEL
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88886_CEL 

# set working directory
workingDir="$1"

# set input CEL path
celPath="$2"

# set input CEL directory
celDir="$3"

# make sure to make necessary directories
mkdir $workingDir"/GBCF_bioinformatics_DxTerity"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData"
mkdir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/"$celDir

# make sure to move CEL files
mv $celPath/$celDir $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/"

# unzip the gz CEL files
gunzip $workingDir"/GBCF_bioinformatics_DxTerity/rma_aromaAffy/rawData/"$celDir"/"*".gz"
