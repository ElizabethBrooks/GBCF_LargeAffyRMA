#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -r n
#$ -N transformRMA_jobOutput

# BASH script to subset columns of normalized data and perform log transformation

# usage: qsub logTransformNormalizedCounts_driver.sh workingDir celSet
# usage ex: qsub logTransformNormalizedCounts_driver.sh /afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results GSE8888n_4_5_6_CEL
# usage ex: qsub logTransformNormalizedCounts_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy/results GSE88884_CEL
# usage ex: qsub logTransformNormalizedCounts_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy/results GSE88885_CEL
# usage ex: qsub logTransformNormalizedCounts_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity/rma_aromaAffy/results GSE88886_CEL
# usage ex: qsub logTransformNormalizedCounts_driver.sh /afs/crc.nd.edu/group/genomics/SCARIF/GBCF_bioinformatics_DxTerity_test/rma_aromaAffy/results GSE88886_CEL


# load necessary software
module load bio

# set working directory
workingDir="$1"
#workingDir="/afs/crc.nd.edu/group/genomics/Mando/GBCF_bioinformatics_DxTerity_combined/rma_aromaAffy/results"

# define CEL set
celSet="$2"
#celSet="GSE8888n_4_5_6_CEL"

# set the number of columns
numCols=$(($(head -1 $workingDir"/normalizedLinear_RMA_"$celSet".csv" | sed 's/,/,\n/g' | grep "," | wc -l)+1))

# check message
echo "The number of samples to process is $(($numCols-6))"

# add summary data to the transformed data file
cut -d , -f 1-6 $workingDir"/normalizedLinear_RMA_"$celSet".csv" | sed 's/"//g' > $workingDir"/normalizedLog_RMA_"$celSet".csv"

# loop over each column for each sample
# the first 6 columns are summary data
for i in $(seq 7 $numCols); do
	# status message
	echo "Transforming column $i..."
	# retrieve the sample column data
	cut -d "," -f $i $workingDir"/normalizedLinear_RMA_"$celSet".csv" | sed 's/"//g' > $workingDir"/normalizedLinear_RMA_"$celSet"_col"$i".csv"
	# perform log2 transformation of the column
	Rscript logTransformNormalizedCounts.r $workingDir $celSet col$i
	# clean up
	rm $workingDir"/normalizedLinear_RMA_"$celSet"_col"$i".csv"
	# status message
	echo "Merging column $i..."
	# add trandformed data
	paste -d , $workingDir"/normalizedLog_RMA_"$celSet".csv" $workingDir"/normalizedLog_RMA_"$celSet"_col"$i".csv" > $workingDir"/tmp_normalizedLog_RMA_"$celSet".csv"
	# overwrite using the tmp copy for pasting
	mv $workingDir"/tmp_normalizedLog_RMA_"$celSet".csv" $workingDir"/normalizedLog_RMA_"$celSet".csv"
	# clean up
	rm $workingDir"/normalizedLog_RMA_"$celSet"_col"$i".csv"
done

# status message
echo "Analysis complete!"
