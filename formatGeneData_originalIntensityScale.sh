#!/bin/bash

# BASH script to update affy data Ensembl transcript IDs with HGNC symbols
# usage: bash formatGeneData.sh workingDir celSet mapFile
# usage ex: bash formatGeneData.sh /Users/bamflappy/GBCF/DxTerity/Data/Normalized/NormalizedMerged GSE8888n_4_5_6 /Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map_cleaned.csv
# usage ex: bash formatGeneData.sh /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results GSE8888n_4_5_6 /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results/HTA_2_0_HGNC_map_cleaned.csv
# usage ex: bash formatGeneData.sh /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/Data/Normalized/NormalizedMerged/ GSE8888n_4_5_6 /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/Data/Annotations/HTA_2_0_HGNC_map_cleaned.csv

# set inputs directory
workingDir="$1"

# set CEL set
celSet="$2"

# set path to the cleaned HTA 2.0 and HGNC mapping file
mapFile=$3

# set input affy data file name
affyDataIn=$workingDir"/normalizedOriginalIntensityScale_transcripts_"$celSet".csv"

# set output affy data file name
affyDataOut=$workingDir"/normalizedOriginalIntensityScale_genes_"$celSet".csv"

# add header to results file
# probe,symbol,expression
echo "probe,symbol" > $workingDir"/tmp_header1.csv"
head -1 $affyDataIn | cut -d "," -f 2- > $workingDir"/tmp_header2.csv"
paste -d , $workingDir"/tmp_header1.csv" $workingDir"/tmp_header2.csv" > $affyDataOut
# test
paste -d , $workingDir"/tmp_header1.csv" $workingDir"/tmp_header2.csv" > $workingDir"/tmp_probeData.csv"

# clean up
rm $workingDir"/tmp_header1.csv"
rm $workingDir"/tmp_header2.csv"

# create file to track transcripts without HGNC symbols
exOut=$workingDir"/genes_noMapping_"$celSet".csv"

# add headers
echo "probe" > $exOut

# loop over each probe of the affy data file
while read probe; do
	# retreive transcript ID
	trans=$(echo $probe | cut -d "," -f 1 | sed 's/"//g' | sed 's/\.hg\.1/\.hg/g')
	# retrieve transcript data
	#transData=$(echo $probe | cut -d "," -f 2- | sed 's/\-Inf/NegInf/g')
	transData=$(echo $probe | cut -d "," -f 2-)
	# status message
	echo "Proccessing $trans ..."
	# search the mapping file
	if grep -q "^$trans," $mapFile; then 
		# retrieve HGNC symbols for the current transcript
   		grep "^$trans," $mapFile > $workingDir"/tmp_transID_HGNC.csv"
		# add affy data
		sed -e "s/$/,$transData/" $workingDir"/tmp_transID_HGNC.csv" > $workingDir"/tmp_transData.csv"
		# add the probe,symbol,data to the final file
		cat $workingDir"/tmp_transData.csv" >> $affyDataOut
	else
		# output transcripts without HGNC symbols
		echo $trans >> $exOut
	fi
done < $affyDataIn

# status message
echo "Proccessed!"

# clean up
rm $workingDir"/tmp_transID_HGNC.csv"
rm $workingDir"/tmp_transData.csv"
