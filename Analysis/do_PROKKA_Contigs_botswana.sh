#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To annotate contings with PROKKA and create the dataset.
#Dependences use PROKKA
 
echo "Start proscessing"


#Create an alignment file
cd /vol/IDK2/shotgun_metagenomes/botswana/multi_output/bins
mkdir annotations

for i in *.fa;
  do 


   
    /vol/IDK2/prokka/bin/prokka   "$i"  --outdir annotations/"$i"   --cpus 24 --force 

	echo "$F"

done

echo "All complete"

					    	                       							
