#/bin/bash
#Author: Ioannis Kampouris
#Purpose: To remove low quality sequences from metagenomic reads
#Dependences cutadapt

cd /vol/IDK/shotgun_metagenomes/botswana
find -name "*GR*_1\.fq\.gz" |sed 's/^..//' > Botswana_samplelist.txt
mkdir reports
mkdir filtered
filename='Botswana_samplelist.txt' 

echo "Start filtering"


while read i;
	do
	F="$i"
	R=$(echo ${i} | sed "s/1.fq.gz/2.fq.gz/")
	FW=$(echo ${F} | sed "s/1.fq.gz/Filt_1.fq.gz/")
	RE=$(echo ${R} | sed "s/2.fq.gz/Filt_2.fq.gz/")

	
	echo "Forward is $FW"
	echo "Reverse is $RE"
	
 cutadapt -m 50 -e 2 -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT    -o ${FW} -p ${RE} -j 23 \
 ${F} ${R}   \
 > ${F}.log
echo "$F"
echo "$R"
 
done<"$filename"

find . -name '*Filt*.gz' -exec mv {} filtered \;
find . -name '*.log' -exec mv {} reports \;

 
