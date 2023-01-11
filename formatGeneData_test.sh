#!/bin/bash

# BASH script to test updated affy data Ensembl transcript IDs with HGNC symbols
# usage: bash formatGeneData_test.sh workingDir celSet mapFile
# usage ex: bash formatGeneData_test.sh /Users/bamflappy/GBCF/DxTerity/Data/Normalized/NormalizedMerged GSE8888n_4_5_6

# set inputs directory
workingDir="$1"

# set CEL set
celSet="$2"

# set output affy data file name
affyDataOut=$workingDir"/normalizedLogTransformed_genes_"$celSet".csv"

# verify resulting data file
while read probe; do
	numLines=$(echo $probe | sed 's/,/,\n/g' | grep "," | wc -l)
	echo "Fields = $numLines"
	if [[ numLines -ne 3147 ]]; then
		echo $probe >> $workingDir"/tmp_probeData.csv"
	fi
done < $affyDataOut

# status message
echo "Proccessed!"
