#!/bin/bash

# BASH script to update affy data Ensembl transcript IDs with HGNC symbols
# usage: bash formatGeneData.sh workingDir celSet mapFile
# usage ex: bash formatGeneData.sh /Users/bamflappy/GBCF/DxTerity/Data/Normalized/NormalizedMerged GSE8888n_4_5_6 /Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map_cleaned.csv

# set inputs directory
workingDir="$1"

# set CEL set
celSet="$2"

# set input affy data file name
affyDataIn=$workingDir"/normalizedLogTransformed_transcripts_"$celSet".csv"

# set output affy data file name
affyDataOut=$workingDir"/normalizedLogTransformed_genes_"$celSet".csv"

# set path to the cleaned HTA 2.0 and HGNC mapping file
mapFile="/Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map_cleaned.csv"

# add header to results file
# probe,symbol,expression
echo "probe,symbol" > $workingDir"/tmp_header1.csv"
head -1 $affyDataIn | cut -d "," -f 2- | sed 's/"//g' > $workingDir"/tmp_header2.csv"
paste -d , $workingDir"/tmp_header1.csv" $workingDir"/tmp_header2.csv" > $affyDataOut

# clean up
rm $workingDir"/tmp_header1.csv"
rm $workingDir"/tmp_header2.csv"

# create file to track transcripts without HGNC symbols
exOut=$workingDir"/genes_noMapping_"$celSet".csv"

# add header
echo "probe" > $exOut

# loop over each probe of the affy data file
while IFS= read -r probe; do
	# retreive transcript ID
	trans=$(echo $probe | cut -d "," -f 1 | sed 's/"//g' | sed s'/\.hg\.1/\.hg/g')
	transTag=$trans","
	# retrieve transcript data
	transData=$(echo $probe | cut -d "," -f 2- | sed 's/"//g')
	# status message
	echo "Proccessing $trans ..."
	# search the mapping file
	if grep -q $transTag $mapFile; then 
		# retrieve HGNC symbols for the current transcript
   		grep $transTag $mapFile | cut -d "," -f 2 | sed '/^$/d' > $workingDir"/tmp_transIDs.csv"
		# loop over each HGNC symbol
		while IFS= read -r symbol; do
			# write out the transcript ID, HGNC symbol, and expression values
			echo $transTag$symbol","$transData >> $affyDataOut
		done < $workingDir"/tmp_transIDs.csv"
	else
		# output transcripts without HGNC symbols
		echo $trans >> $exOut
	fi
done < $affyDataIn

# status message
echo "Proccessed!"

# clean up
rm $workingDir"/tmp_transIDs.csv"
