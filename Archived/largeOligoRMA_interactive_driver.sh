#!/bin/bash

# Script to run RMA normalization with the oligo R package using a minimum of 16 cores (171GB)
# the raw data is 82GB total, and a vector is created during normalization that is about 162GB
# since each core has 10.7GB RAM available, slightly more than 15 cores are needed for the analysis

# load the R v4 module
module load R/4.2.1

# normalize CEL files
Rscript largeOligoRMA_interactive.R
