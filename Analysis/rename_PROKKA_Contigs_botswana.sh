#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To rename annotated bins with PROKKA and create the dataset.
#Dependences use PROKKA
 
echo "Start proscessing"


#Create an alignment file
cd /vol/IDK2/shotgun_metagenomes/botswana/multi_output/bins/annotations

for i in *.fa/*tsv ;
  do 
	S=$(echo ${i} | sed "s/\\//_/g")
   
    cp  "$i"  "$S" 

	echo "$S"

done

for i in *.fa/*faa ;
  do 
	S=$(echo ${i} | sed "s/\\//_/g")
   
    cp  "$i"  "$S" 

	echo "$S"

done

echo "All complete"

					    	                       							
