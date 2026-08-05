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
library(phangorn)
library(reshape2)


pathMG= "C:/Users/ioannis.kampouris/Desktop/Botswana_MG/"

stats_complete_mags=read_excel(paste0(pathMG,  "mags_stat.xlsx"))%>%filter(Replication=="Unique")
stats_complete_mags$lineage= gsub(".__","",stats_complete_mags$lineage)
stats_complete_mags$lineage=gsub("root.","",stats_complete_mags$lineage)
stats_complete_mags$lineage=gsub("\\*","",stats_complete_mags$lineage)


setwd( "C:/Users/ioannis.kampouris/Desktop/Botswana_MG/MGs/antismash_predictions")
df4=list()
for (j in c(unique(stats_complete_mags$Bin))){
  print(paste0(j))
list.files=list.files( path=paste0(j), pattern = "region*.*gbk")
for (i in c(list.files)){
  paste0(i)
path1=paste0(j,"/",i)
regions= read_table(path1, col_names = F)
start=as.numeric( regions[13,4, drop=T])
end=as.numeric( regions[14,4, drop=T])

MAGA61= geneviewer::read_gbk( path = path1)
df1= geneviewer::gbk_features_to_df(MAGA61, feature = "protocluster")

if( nrow(df1)>1 ){

for (cl in c(unique(df1$product)) ) {
print(paste0(cl))
df1.2=filter(df1, product==paste0(cl))    
df2= geneviewer::gbk_features_to_df(MAGA61, feature = "CDS")
df3=df2[,c("translation", "region","strand","start",  "end")] %>%na.omit()%>%
  filter(start>=df1.2$start&end<=df1.2$end)
df3$product=  df1.2$product
df3$contig= gsub(".region*.*", "", df1.2$cluster)

df3$start2=df3$start+start
df3$end2=df3$end+start
df3$gene_number=nrow(df3)
df3$Bin=paste0(j)
df4=rbind(df3, df4)

}}else{
df2= geneviewer::gbk_features_to_df(MAGA61, feature = "CDS")
df3=df2[,c("translation", "region","strand","start",  "end")] %>%na.omit()
df3$product=  df1$product
df3$contig= gsub(".region*.*", "", df1$cluster)

df3$start2=df3$start+start
df3$end2=df3$end+start
df3$gene_number=nrow(df3)
df3$Bin=paste0(j)
df4=rbind(df3, df4)
}
}
}


df5= df4%>%full_join(stats_complete_mags[,c("Bin", "lineage")])%>%na.omit()%>%
  select(product, gene_number, contig, lineage)%>%aggregate(gene_number~product+contig + lineage, mean)%>%dcast(product + lineage~., value.var = "gene_number",  sum)

ggplot(df5,aes( axis1=lineage, axis2=product))+
  geom_alluvium(aes(fill = `.`), linesize=3, colour="black") +
  geom_stratum()+
  geom_text(stat="stratum",aes(label = after_stat(stratum)),size=4)+theme_void()+
  scale_fill_distiller(palette = "Blues", name="Gene Number")+theme(legend.position = "top")


geneviewer::GC_chart(df3, group="product",strand = "strand",width = "100%", cluster = "contig", height = "600px")%>%
geneviewer::GC_clusterLabel(unique(df4$contig))
library(ape)
tree1=read.tree("C:/Users/ioannis.kampouris/Desktop/Botswana_MG/contigs/classify/gtdbtk.ar53.classify.tree")
nodesupport = c(gsub("RS*.*","",gsub("GB_*.*","" , tree1$tip.label )))
tree1$tip.label2=gsub("RS*.*","",gsub("GB_*.*","" , tree1$tip.label ))

library(ggtree)
p=ggtree(tree1, layout = "fan")
p$data$label2=gsub("RS*.*","",gsub("GB_*.*","" , p$data$label))

p+geom_tippoint(aes(color=label, alpha=label, size=10))+scale_alpha_discrete(range= c(0,2))+
  geom_tippoint(aes(colour=label2))
