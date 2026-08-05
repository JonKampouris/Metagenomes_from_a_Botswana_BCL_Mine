#/bin/bash
#Author: Ioannis Kampouris
#Purpose: To perform assembly of metagenomes
#Dependences use megahit.

 

#Authors: Ioannis Kampouris 
# This script performs the analysis of the Botswana metagenomes
#Required Tools:
# MEGAHIT 
# 
echo "Start proscessing"
mkdir shotgun_metagenomes/botswana/contigs


find -name "*Filt_phix_1*" > B_filelists.txt

filename='B_filelists.txt'
while read i;

	do  
		R=$(echo ${i} | sed "s/Filt_phix_1/Filt_phix_2/")
			M=$(echo ${i} | sed "s/Filt_phix_1.fq.gz/Filt_phix/")
				M=$(echo ${M} | sed "s/\\/filtered/\\/contigs/")
					echo "$M"  
     megahit -1 "$i" -2 "$R" -o "$M" --k-min 17 --k-max 127 --k-step 10    -t 25 --min-contig-len 1500
					    	               
					    	                 
echo "Cycle complete"
					    	                 
done<"$filename"
					    	                       
echo "All complete"

					    	                       							
