#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeOligoRMA_jobOutput

# usage: bash largeOligoRMA_driver.sh celDirPath celDir
# usage ex: bash largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE8888n_4_5_6_CEL
# usage ex: bash largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88884_CEL
# usage ex: bash largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88885_CEL
# usage ex: bash largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88886_CEL

# set input CEL path
celPath="$1"

# set input CEL directory
celDir="$2"

# make sure to make necessary directories
mkdir "rma_aromaAffy"
mkdir "rma_aromaAffy/rawData"
mkdir "rma_aromaAffy/rawData/"$celDir

# make sure to move CEL files
mv $celPath/$celDir "rma_aromaAffy/rawData/"$celDir

# unzip the gz CEL files
gunzip "rma_aromaAffy/rawData/"$celDir"/"*".gz"
