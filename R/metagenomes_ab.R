library(tidyverse)
library(ggplot2)
library(plyr)
library(dplyr)
library(readr)
library(readxl)
library(ggpubr)
library(stringi)
library(ggraph)
library(igraph)
library(reshape2)

pathMG= "C:/Users/ioannis.kampouris/Desktop/Botswana_MG/"
list1= as.data.frame( list.files(path = paste0(pathMG), pattern = "taxonomy*.txt"))
samples=list()
for(i in unique(list1$`list.files(path = paste0(pathMG), pattern = "taxonomy*.txt")`)){
print(paste0(pathMG,i))
file1=read.table(file =  paste0(pathMG,i), sep = "\t")%>%dcast(., V2~.,  length)
samplenm= paste0("Sample_", gsub("_Filt_*.*", "", gsub("*.*_GR_", "", i)))
file1$Sample= paste0(samplenm[1])
colnames(file1)=c("Taxonomy","RA", "Sample")
samples=rbind(file1,samples)


}
samples$Taxonomy[samples$Taxonomy==""]="Unclassified"
samples2= dcast(samples, Taxonomy~Sample, value.var = "RA", sum)%>%
  filter(str_detect( Taxonomy, ("Bacteria")))%>%filter(Taxonomy!="Unclassified")
samples2[,2:ncol(samples2)]=apply(samples2[,2:ncol(samples2)], 2, function (x) 100*(x)/sum(x))

rownames(samples2)=samples2$Taxonomy
medians=as.data.frame( apply(samples2[,2:ncol(samples2)], 1, function (x) median(x)))

colnames(medians)="median"
medians2=medians[-which(rownames(medians)%in%c("Unclassified","Bacteria;","Archaea;")),,drop=F]%>%as.data.frame()
colnames(medians)="median"
medians2=medians2[order(medians2$median,  decreasing = TRUE),,drop=F]
medians2=medians2[1:10,,drop=F]
samples3=gather(filter( samples2, Taxonomy%in%c(rownames(medians2))),-Taxonomy, key="Sample", value = "RA")
means=as.data.frame( apply(samples2[,2:ncol(samples2)], 1, function (x) mean(x)))
sds=as.data.frame( apply(samples2[,2:ncol(samples2)], 1, function (x) sd(x)))
mean_sd= cbind(means,sds)
mean_sd2=mean_sd[rownames(medians2),]


plot1=
ggplot(samples3, aes(fill=str_sub(Taxonomy, end=-2),
y=Sample,x=(RA)))+geom_bar(stat="identity", position = "dodge")+
  scale_fill_brewer(palette = "Spectral", name="Taxonomy")+
  theme_pubr(legend = "top")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="italic", colour = "black")) +
  theme(legend.title =  element_text( size=20, face="bold", colour = "black"))+ xlab("SSU RA(%)")+ylab("")+
  guides( fill=guide_legend(ncol=2, title.position = "top", 
                      override.aes = c(size=10)))


plot1
samples3=filter(samples2, str_detect(Taxonomy, "Staphylococcus|Enterococcus|Pseudomonas|Klebsiella|Acinetobacter"))
samples4=data.frame(RA= colSums(samples3[,-1, drop=F], ))
samples4$S=gsub("Sample_","",rownames(samples4))
plot1= ggplot(samples4, aes(x=as.numeric(S),y=log10(RA+1)))+
  geom_point(size=10,shape=21,fill="skyblue4")+stat_cor(method = "spearman")+
  xlab("Distance from the mine")


samples5=samples3
samples5=gather(samples5, -Taxonomy, key="S", value="RA")
samples5$S=gsub("Sample_","",samples5$S)

plot1= ggplot(samples5, aes(x=as.numeric(S),y=log10(RA+1)))+
  geom_point(size=10,shape=21,fill="skyblue4")+stat_cor(method = "spearman")+
  xlab("Distance from the mine")+facet_wrap(~Taxonomy, scales = "free", ncol=2)


chemical_data=read_xlsx( "C:/Users/ioannis.kampouris/Desktop/Botswana_MG/chemical_info.xlsx")
samples4=full_join(samples3, chemical_data)
samples4= dcast(samples3%>%mutate(RA=log10(RA+1)),
Sample~Taxonomy, value.var = "RA", sum )%>%column_to_rownames(var="Sample")
distance=vegan::vegdist(samples4, method = "bray")
samples5= cbind(
chemical_data[,c(2:6)],samples4[chemical_data$Sample,]
)
correlations=Hmisc::rcorr(samples5%>%as.matrix(), type = "pearson")


flattenCorrMatrix <- function(cormat, pmat) {
  ut <- upper.tri(cormat)
  data.frame(
    row = rownames(cormat)[row(cormat)[ut]],
    column = rownames(cormat)[col(cormat)[ut]],
    cor  =(cormat)[ut],
    p = pmat[ut]
  )
}
correlations2= flattenCorrMatrix(correlations$r, correlations$P)
correlations2$padj=p.adjust(correlations2$p, method = "BH")
correlations3=filter(correlations2, padj<0.05)
samples2= dcast(samples, Taxonomy~Sample, value.var = "RA", sum)%>%
  filter(!str_detect( Taxonomy, ("Chloroplast|Mitochondria")))

write.csv(samples2,file = paste0(pathMG,"taxonomy.csv"))
bacterial_community=filter(samples2, str_detect(Taxonomy, "Bacteria"))
Archaeal_community=filter(samples2, str_detect(Taxonomy, "Archaea"))

prokaryotes=filter(samples2, str_detect(Taxonomy, "Bacteria|Archaea"))%>%separate(Taxonomy, into=c("Kingdom","Phylum", "Class"), sep=";")

prokaryotes2=aggregate(prokaryotes[,c(2, 4:10)], .~Phylum, FUN = "sum")%>%filter(Phylum!="")
prokaryotes2[,2:8]=apply(prokaryotes2[,2:8], 2, function(x) 100*(x)/sum(x))
prokaryotes3=prokaryotes2%>%gather(., key="Sample", -Phylum, value="RA")
prokaryotes_median=dcast(prokaryotes3, Phylum~., value.var = "RA",  median )
prokaryotes_median=prokaryotes_median[order(prokaryotes_median$.,  decreasing = TRUE),,drop=F]
dcast(prokaryotes3, Phylum~., value.var = "RA",  mean )
dcast(prokaryotes3, Phylum~., value.var = "RA",  sd )

prokaryotes_median=prokaryotes_median[1:10,,drop=F]
prokaryotes4=gather(prokaryotes2%>%filter(Phylum%in%c(c(prokaryotes_median$Phylum))),-Phylum, key="Sample",  value="RA")
prokaryotes4$Phylum[prokaryotes4$Phylum=="Thaumarchaeota"]="Nitrosphaerota"

prokaryotes4$Phylum[prokaryotes4$Phylum=="eria"]="eriota"

plot2= ggplot(prokaryotes4, aes(x=RA, y=Phylum))+geom_boxplot(fill="skyblue4") +
  theme_pubr()+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+

    theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.y = element_text( size=20, face="italic", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="italic", colour = "black")) +
  theme(legend.title =  element_text( size=20, face="bold", colour = "black"))+ xlab("SSU RA(%)")+ylab("")+
  guides( fill=guide_legend(ncol=1, title.position = "top", 
                            override.aes = c(size=20)))

tiff(filename = paste0(pathMG, "/Plot1.png"), height = 3500, width = 8000, res = 300)
print(cowplot::plot_grid(plot2, plot1, align="v", ncol=1, labels = c("A)","B)"),label_size = 40))
dev.off()



list2= as.data.frame( list.files(path = paste0(pathMG), pattern = "csv"))
samples=list()
for(i in unique(list2$`list.files(path = paste0(pathMG), pattern = "csv")`)){
  (paste0(pathMG,i))
  
  file1=read.csv(file =  paste0(pathMG,i))
  file1=separate(file1, colnames(file1), into = c("col1", "col2"),sep = "\t")
  samplenm= paste0("Sample_", gsub("_Filt_*.*", "", gsub("*.*_GR_", "", i)))
  file1$Sample= paste0(samplenm[1])
  colnames(file1)=c("Katlengo_Contigs","RA", "Sample")
  samples=rbind(file1,samples)
  
}
samples$Katlengo_Contigs[samples$Katlengo_Contigs=="-1"]="Non-Mapped_Reads"
samples$RA=as.numeric(samples$RA)
Samples=dcast(samples,Katlengo_Contigs~Sample, value.var = "RA", sum)
Samples[,2:ncol(Samples)]=apply(Samples[,2:ncol(Samples)],2,function(x) 100*(x)/sum(x))
