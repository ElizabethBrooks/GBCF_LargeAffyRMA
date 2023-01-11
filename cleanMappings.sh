#!/bin/bash

# BASH script to clean the HTA 2.0 to HGNC mapping file
# usage: bash cleanMappings.sh

# set path to the HTA 2.0 and HGNC mapping file
mapFileIn="/Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map.csv"

# set path to the cleaned HTA 2.0 and HGNC mapping file
mapFileOut="/Users/bamflappy/GBCF/DxTerity/Data/Annotations/HTA_2_0_HGNC_map_cleaned.csv"

# clean map file by removing " characters
cat $mapFileIn | sed '/""/d' | sed 's/"//g' > $mapFileOut 