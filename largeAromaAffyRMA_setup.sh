# usage: qsub largeOligoRMA_driver.sh celDir cdfPath
# usage ex: qsub largeOligoRMA_driver.sh /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/GSE8888n_4_5_6_CEL /scratch365/ebrooks5/GBCF_bioinformatics_DxTerity/HTA-2_0,r1,gene.cdf

# set input CEL directory
celDir="$1"

# set input CDF path
cdfPath="$2"

# make sure to make necessary directories
mkdir "rma_aromaAffy"
mkdir "rma_aromaAffy/rawData"
mkdir "rma_aromaAffy/annotationData"
mkdir "rma_aromaAffy/annotationData/chipTypes"
mkdir "rma_aromaAffy/annotationData/chipTypes/HTA-2_0/"

# make sure to move CEL files
mv $celDir "rma_aromaAffy/rawData/"

# make sure to copy CDF file
cp $cdfPath "rma_aromaAffy/annotationData/chipTypes/HTA-2_0/"
