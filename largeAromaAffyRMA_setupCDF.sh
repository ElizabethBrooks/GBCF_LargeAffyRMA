# usage: qsub largeOligoRMA_driver.sh cdfPath
# usage ex: qsub largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/HTA-2_0.r1.gene.cdf

# set input CDF path
cdfPath="$1"

# make sure to make necessary directories
mkdir "rma_aromaAffy/annotationData"
mkdir "rma_aromaAffy/annotationData/chipTypes"
mkdir "rma_aromaAffy/annotationData/chipTypes/HTA-2_0/"

# convert CDF file
Rscript convertCDF_affxparser.R $cdfPath
