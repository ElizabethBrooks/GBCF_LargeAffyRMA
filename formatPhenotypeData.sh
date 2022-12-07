# BASH script to format phenotype data csv files associated with CEL files
# usage: bash formatPhenotypeData.sh

# set the inputs path
inputsPath="/Users/bamflappy/GBCF/DxTerity"

# retrieve sample data csv files from the following urls
#https://www.ncbi.nlm.nih.gov/geo/browse/?view=samples&series=88884
#https://www.ncbi.nlm.nih.gov/geo/browse/?view=samples&series=88885
#https://www.ncbi.nlm.nih.gov/geo/browse/?view=samples&series=88886

# add headers to each phenotype data csv file
echo "Accession,Subject,Patient,Treatment" > $inputsPath"/samplePhenotypes_GSE88884.csv"
echo "Accession,Subject,Patient,Treatment" > $inputsPath"/samplePhenotypes_GSE88885.csv"
echo "Accession,Subject,Patient,Treatment" > $inputsPath"/samplePhenotypes_GSE88886.csv"

# retrieve selected phenotype data from each sample file
tail -n+2 $inputsPath"/sample_GSE88884.csv" | cut -d "," -f 1-4 | sed 's/"//g' | sed 's/[[:blank:]]//g' >> $inputsPath"/samplePhenotypes_GSE88884.csv"
tail -n+2 $inputsPath"/sample_GSE88885.csv" | cut -d "," -f 1-4 | sed 's/"//g' | sed 's/[[:blank:]]//g' >> $inputsPath"/samplePhenotypes_GSE88885.csv"
tail -n+2 $inputsPath"/sample_GSE88886.csv" | cut -d "," -f 1-4 | sed 's/"//g' | sed 's/[[:blank:]]//g' >> $inputsPath"/samplePhenotypes_GSE88886.csv"

# create a merged phenotype data file
cat $inputsPath"/samplePhenotypes_GSE88884.csv" > $inputsPath"/samplePhenotypes_GSE8888n_4_5_6.csv"
tail -n+2 $inputsPath"/samplePhenotypes_GSE88885.csv" >> $inputsPath"/samplePhenotypes_GSE8888n_4_5_6.csv"
tail -n+2 $inputsPath"/samplePhenotypes_GSE88886.csv" >> $inputsPath"/samplePhenotypes_GSE8888n_4_5_6.csv"
