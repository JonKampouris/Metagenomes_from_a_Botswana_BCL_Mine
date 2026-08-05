#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To map assembled contigs to  of metagenomes
#Dependences: ngless.

 
echo "Start proscessing"
mkdir shotgun_metagenomes/botswana/MAGS

find -name "SemiBin_*"  > samples_for_moving.txt


 
 
 
 
filename='samples_for_moving.txt'
while read i;

	do  
			M1=$(echo ${i} | sed "s/.output_bins./_/")
			M2=$(echo ${M1} | sed "s/bins/MAGS/")
					echo "$M2"  

cp "$i" "$M2"		    	               
					    	                 
echo "Cycle complete"
					    	                 
done<"$filename"
					    	                       
echo "All complete"

