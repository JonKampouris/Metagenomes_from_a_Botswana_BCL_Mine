library(tidyverse)
library(ggplot2)
library(plyr)
library(dplyr)
library(readr)
library(readxl)
library(ggpubr)
library(stringi)
library(ggraph)
library(Biostrings)


setwd( "C:/Users/ioannis.kampouris/Desktop/Botswana_MG/contigs")

listoffiles= list.files(pattern = "fa")

samples_list=list()
for(i in unique(listoffiles)){

fasta1= Biostrings::readDNAStringSet(paste0(i), format = "fasta")

my.size=width(fasta1)
N50_cont =N50(my.size)
total_nucl= (sum(nchar(fasta1)))
length_nucl= length( unique(fasta1))
frame1=data.frame(Sample=paste0(i), total_nucl=total_nucl, no_contigs=length_nucl, N50=N50_cont )
samples_list=rbind(samples_list,frame1)
}
samples_list=as.data.frame(samples_list)
