#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To predict ORFs filtered with prodigal
#Dependences: prodigal.

 
echo "Start proscessing"

cd /vol/IDK/shotgun_metagenomes/botswana/bins/
find -name "*.fa" |sed 's/^..//' > MG_Botswana_samplelist.txt
mkdir gene_predictions

filename='MG_Botswana_samplelist.txt' 

echo "Start filtering"
while read i;
	do
	echo "Gene file is $Genes"
	echo "Protein file is $Proteins"
	Sample=$(echo ${i} | sed "s/.output_bins./_output_bins_/")
	Genes=$(echo ${Sample} | sed "s/fa/Genes/")
	Proteins=$(echo ${Genes} | sed "s/Genes/Proteins\\.faa/")
	dna=$(echo ${Genes} | sed "s/Genes/dna\\.faa/")
	prodigal -i "$i" -o gene_predictions/"$Genes" -a gene_predictions/"$Proteins" -d "$dna" -p single
     
	

done<"$filename"
