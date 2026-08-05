#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To map assembled contigs to  of metagenomes
#Dependences: ngless.

 
echo "Start proscessing"
mkdir shotgun_metagenomes/botswana/mapped


ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L01_GR_7_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L01_GR_7_Filt_phix_2.fq.gz /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L01_GR_7_Filt_phix/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L01_GR_7_Filt_phix_mapped.sam -j 23 -t /vol/I
   
ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L01_GR_6_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L01_GR_6_Filt_phix_2.fq.gz /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L01_GR_6_Filt_phix/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L01_GR_6_Filt_phix_mapped.sam -j 23 -t /vol/IDK

ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_5_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_5_Filt_phix_2.fq.gz /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L04_GR_5_Filt_phix/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L04_GR_5_Filt_phix_mapped.sam -j 23 -t /vol/IDK


ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_4_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_4_Filt_phix_2.fq.gz  /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L04_GR_4/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L04_GR_4_Filt_phix.sam -j 23 -t /vol/IDK


ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_3_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_3_Filt_phix_2.fq.gz /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L04_GR_3_Filt_phix/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L04_GR_3_Filt_phix.sam -j 23 -t /vol/IDK


ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_2_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L04_GR_2_Filt_phix_2.fq.gz /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L04_GR_2_Filt_phix/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L04_GR_2_Filt_phix_mapped.sam -j 23 -t /vol/IDK


ngless  scripts/botswana_mapping_to_reads.ngl /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L02_GR_1_Filt_phix_1.fq.gz /vol/IDK/shotgun_metagenomes/botswana/filtered/V350134810_L02_GR_1_Filt_phix_2.fq.gz /vol/IDK/shotgun_metagenomes/botswana/contigs/V350134810_L02_GR_1_Filt_phix/final.contigs.fa /vol/IDK/shotgun_metagenomes/botswana/mapped/V350134810_L02_GR_1_Filt_phix_mapped.sam -j 23 -t /vol/IDK

				    	               
