#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N largeAffyRMA_jobOutput

# load the bio module
module load bio

# normalize CEL files
Rscript largeAffyRMA.R