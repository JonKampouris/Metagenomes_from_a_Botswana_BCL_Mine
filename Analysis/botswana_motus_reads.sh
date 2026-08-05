#!/bin/bash
#Author: Ioannis Kampouris
#Purpose: To map filtered reads with mOTUs
#Dependences: mOTUs.

 
echo "Start proscessing"
cd filtered



mkdir katlengo_map

	
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L02_GR_1_Filt_phix_1.fq  V350134810_L02_GR_1_Filt_phix_2.fq  katlengo.faa  katlengo_map/V350134810_L02_GR_1_Filt_phix_1.csv -j 23 -t /vol/IDK2
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L01_GR_6_Filt_phix_1.fq  V350134810_L01_GR_6_Filt_phix_2.fq katlengo.faa  katlengo_map/V350134810_L01_GR_6_Filt_phix_1.csv -j 23 -t /vol/IDK2
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L04_GR_5_Filt_phix_1.fq  V350134810_L04_GR_5_Filt_phix_2.fq  katlengo.faa  katlengo_map/V350134810_L04_GR_5_Filt_phix_1.csv -j 23 -t /vol/IDK2
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L04_GR_4_Filt_phix_1.fq  V350134810_L04_GR_4_Filt_phix_2.fq  katlengo.faa  katlengo_map/V350134810_L04_GR_4_Filt_phix_1.csv -j 23 -t /vol/IDK2
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L04_GR_3_Filt_phix_1.fq  V350134810_L04_GR_3_Filt_phix_2.fq  katlengo.faa  katlengo_map/V350134810_L04_GR_3_Filt_phix_1.csv -j 23 -t /vol/IDK2
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L04_GR_2_Filt_phix_1.fq  V350134810_L04_GR_2_Filt_phix_2.fq  katlengo.faa  katlengo_map/V350134810_L04_GR_2_Filt_phix_1.csv -j 23 -t /vol/IDK2
ngless /vol/IDK/scripts/botswana_motus.ngl   V350134810_L03_GR_7_Filt_phix_1.fq  V350134810_L03_GR_7_Filt_phix_2.fq  katlengo.faa  katlengo_map/V350134810_L03_GR_7_Filt_phix_1.csv -j 23 -t /vol/IDK2

 


