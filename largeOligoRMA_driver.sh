#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeOligoRMA_jobOutput

# load the bio module
module load R/4.2.1

# normalize CEL files
Rscript largeOligoRMA.R
