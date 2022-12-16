#!/bin/bash

# BASH script to update affy data Ensembl transcript IDs with HGNC symbols
# usage: bash formatGeneData.sh workingDir celSet
# usage ex: qsub largeAromaAffyRMA_driver.sh $workingDir GSE8888n_4_5_6

# set inputs directory
workingDir="$1"

# set CEL set
celSet="$2"

# set input affy data file name
affyDataIn=$workingDir"/normalizedLogTransformed_transcripts_"$celSet

# set output affy data file name
affyDataOut=$workingDir"/normalizedLogTransformed_genes_"$celSet

# set path to the HTA 2.0 and HGNC mapping file
#mapFileIn="/Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map.csv"

# set path to the cleaned HTA 2.0 and HGNC mapping file
mapFileOut="/Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map_cleaned.csv"

# clean map file by removing " characters
#cat $mapFileIn | sed 's/"//g' > $mapFileOut 

# add header to results file
# probe,symbol,expression
echo "probe,symbol" > $workingDir"/tmp_header1.csv"
head -1 $affyDataIn | cut -d "," -f 2- | sed 's/"//g' > $workingDir"/tmp_header2.csv"
paste -d , $workingDir"/tmp_header1.csv" $workingDir"/tmp_header2.csv" > $affyDataOut

# clean up
rm $workingDir"/tmp_header1.csv"
rm $workingDir"/tmp_header2.csv"

# loop over each probe of the affy data file
while IFS= read -r probe; do
	# retreive transcript ID
	trans=$(echo $probe | cut -d "," -f 1 | sed 's/"//g' | sed s'/\.hg\.1/\.hg/g')
	transTag=$trans","
	# retrieve transcript data
	transData=$(echo $probe | cut -d "," -f 2- | sed 's/"//g')
	# search the mapping file
	grep $transTag $mapFileOut | cut -d "," -f 2 | sed '/^$/d' > $workingDir"/tmp_transIDs.csv"
	# status message
	echo "Proccessing $trans ..."
	# loop over each HGNC symbol
	while IFS= read -r symbol; do
		# write out the transcript ID, HGNC symbol, and expression values
		echo $transTag$symbol","$transData >> $affyDataOut
	done < $workingDir"/tmp_transIDs.csv"
done < $affyDataIn

# status message
echo "Proccessed!"

# clean up
rm $workingDir"/tmp_transIDs.csv"
