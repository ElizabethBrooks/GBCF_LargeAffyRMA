#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N downloadCEL_aromaAffy_jobOutput

# usage: qsub largeAromaAffyRMA_setupCEL.sh workingDir celPath celDir chipType
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88884
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88884
# usage ex: qsub largeAromaAffyRMA_setupCEL.sh /afs/crc.nd.edu/group/genomics/SCARIF /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity GSE88884

# set working directory
workingDir="$1"

# set input CEL path
celPath="$2"

# retrieve CEL set number
celSet="$3"

# set CEL data dir name
celDir=$celSet"_CEL"

# create data directory
mkdir $celPath"/"$celDir

# move to data directory
cd $celPath"/"$celDir

# set the web path
webPath="ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE88nnn/"$celSet"/suppl/"$celSet"_RAW.tar"

# download the CEL files
wget $webPath

# extract data files
tar -xf $celSet"_RAW.tar"

# unzip the gz CEL files
gunzip *gz
