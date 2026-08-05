#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To move and rename the contigs.
#Dependences: none.

 
echo "Start proscessing"
mkdir -p /vol/IDK/shotgun_metagenomes/botswana/contigs2
cd /vol/IDK/shotgun_metagenomes/botswana/contigs





find -name "final.contigs.fa"  > samples_for_moving.txt


filename='samples_for_moving.txt'
while read i;

	do  
		M1=$(echo ${i} | sed "s/\\/final/_final/")	
		
   cp "$i"	/vol/IDK/shotgun_metagenomes/botswana/contigs2/"$M1"	    	               
	echo "$M1"				    	                 

done<"$filename"
	

echo "All complete"

