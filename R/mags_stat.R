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


stats_complete_mags=read_excel(paste0("C:/Users/ioannis.kampouris/Desktop/Botswana_MG/mags_stat.xlsx"), sheet = "Sheet6")
stats_complete_mags= as.data.frame( stats_complete_mags[,c(1,2,3,6,18)])%>%na.omit()
stats_classifications=as.data.frame( read_excel(paste0("mags_stat.xlsx"), sheet = "Sheet7"))
stats_complete_mags=as.data.frame(stats_complete_mags)
stats_complete_mags$Genes_No=gsub("'# predicted genes': ","",stats_complete_mags$...18)
stats_complete_mags2= full_join(stats_complete_mags, stats_classifications, by="MAG")
h
stats_complete_mags3=separate(stats_complete_mags2, col = "Classification", into = c("Domain", "Phylum", "Class","Order"), sep = ";")%>%filter(Phylum!="NA")
plot1=ggplot(stats_complete_mags3, aes(x=Completeness, size=`Genome size`, y=Contamination, shape=Domain, fill=paste( Phylum)))+
  geom_point( size=12)+scale_fill_brewer(palette = "Paired", name="Taxonomy") +
  theme_pubr(legend = "top")+
  scale_shape_manual(values = c(21,22))+
  theme(legend.text = element_text( size=20, face="bold", colour = "black")) + 
  theme(legend.title =  element_text( size=20, face="bold", colour = "black")) +
  theme(legend.position = "top")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="italic", colour = "black")) +
  guides(alpha=guide_legend(fill="black"),fill=guide_legend(ncol=3,byrow=TRUE, 
title.position = "top", override.aes=  list(shape = 21)))+
  geom_hline(yintercept = 5)+ylab("Contamination %")+xlab("Completeness %")
plot1

ggsave(filename =  "plot_ComplwithCont.png", width = 15, height = 10)


stats_complete_mags4=filter(stats_complete_mags2, str_detect(Classification, "Eremi")&Completeness>=80&Contamination<5)#%>%separate(Classification,into = c("tax.Kingdom",
#"tax.Phylum","tax.Class","tax.Order", "tax.Family", "tax.Genus"),";" )#%>%
stats_complete_mags4$MAG=gsub("final","", stats_complete_mags4$MAG)
plot2=ggplot(stats_complete_mags4, aes(y=paste0("Sample_", MAG), fill=Classification, x=Completeness))+geom_bar(stat="summary")+
  theme_pubr(legend = "top")+
  geom_point(aes(x=-5, size=(`Genome size`)/1000000,colour=Contamination))+
  scale_size_continuous(range  = c(10,20), name="Genome Size (Mbp)")+
  scale_colour_distiller(palette = "RdBu", name="Contamination")+
  scale_fill_brewer(palette = "Set1", name="Genus Taxonomy")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="italic", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black")) +
  xlab("Completeness (%)")+
  ylab("")+guides(fill=guide_legend(nrow=8,byrow=TRUE, title.position = "top"), 
size=guide_legend(ncol=2,byrow=TRUE, title.position = "top"), colour=guide_legend(ncol=1, title.position = "top", 
                                                                                  override.aes = c(size=20)))
plot2

tiff(filename = paste0(pathMG, "/Plot2.png"), height = 5500, width = 6000, res = 300)
print(cowplot::plot_grid(plot1, plot2, align="v", ncol=1, labels = c("A)","B)"),label_size = 40))
dev.off()


stats_complete_mags4=filter(stats_complete_mags2, str_detect(Classification, "Acidoba")&Completeness>=80&Contamination<5)#%>%separate(Classification,into = c("tax.Kingdom",
#"tax.Phylum","tax.Class","tax.Order", "tax.Family", "tax.Genus"),";" )#%>%
stats_complete_mags4$MAG=gsub("final","", stats_complete_mags4$MAG)
plot2=ggplot(stats_complete_mags4, aes(y=paste0("Sample_", MAG), fill=Classification, x=Completeness))+geom_bar(stat="summary")+
  theme_pubr(legend = "top")+
  geom_point(aes(x=-5, size=(`Genome size`)/1000000,colour=Contamination))+
  scale_size_continuous(range  = c(10,20), name="Genome Size (Mbp)")+
  scale_colour_distiller(palette = "RdBu", name="Contamination")+
  scale_fill_brewer(palette = "Set1", name="Genus Taxonomy")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="italic", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black")) +
  xlab("Completeness (%)")+
  ylab("")+guides(fill=guide_legend(nrow=8,byrow=TRUE, title.position = "top"), 
                  size=guide_legend(ncol=2,byrow=TRUE, title.position = "top"), colour=guide_legend(ncol=1, title.position = "top", 
                                                                                                    override.aes = c(size=20)))
plot2

tiff(filename = paste0(pathMG, "/Acidoba_Plot2.png"), height = 5500, width = 7000, res = 300)
print(plot2)
dev.off()


stats_complete_mags4=filter(stats_complete_mags2, str_detect(Classification, "CSP")&Completeness>=80&Contamination<5)#%>%separate(Classification,into = c("tax.Kingdom",
#"tax.Phylum","tax.Class","tax.Order", "tax.Family", "tax.Genus"),";" )#%>%
stats_complete_mags4$MAG=gsub("final","", stats_complete_mags4$MAG)
plot2=ggplot(stats_complete_mags4, aes(y=paste0("Sample_", MAG), fill=Classification, x=Completeness))+geom_bar(stat="summary")+
  theme_pubr(legend = "top")+
  geom_point(aes(x=-5, size=(`Genome size`)/1000000,colour=Contamination))+
  scale_size_continuous(range  = c(10,20), name="Genome Size (Mbp)")+
  scale_colour_distiller(palette = "RdBu", name="Contamination")+
  scale_fill_brewer(palette = "Set1", name="Genus Taxonomy")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="italic", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black")) +
  xlab("Completeness (%)")+
  ylab("")+guides(fill=guide_legend(nrow=8,byrow=TRUE, title.position = "top"), 
                  size=guide_legend(ncol=2,byrow=TRUE, title.position = "top"), colour=guide_legend(ncol=1, title.position = "top", 
                                                                                                    override.aes = c(size=20)))
plot2

tiff(filename = paste0(pathMG, "/Cloroflexi_Plot2.png"), height = 5500, width = 6000, res = 300)
print(stats_complete_mags4)
dev.off()

pathMG= "C:/Users/ioannis.kampouris/Desktop/Botswana_MG/DiamondBins/"
CARD1=read.csv(paste0(pathMG,"CARDBINS.csv"))

CARD1$MAG=gsub(".fa","", CARD1$bin)

CARDMAGs=full_join( stats_complete_mags2,
                CARD1, by="MAG")%>%na.omit()
library(ggalluvial)
CARDMAGs2=separate(CARDMAGs, col = "Classification", into = c("Domain", "Phylum", "Class","Order", "Family","Genus"), sep = ";")%>%filter(Phylum!="NA")
CARDMAGs2B=dcast(CARDMAGs2,Completeness+Contamination+ Domain+ Genes_No+MAG+Phylum~., value.var = "MAG", length) 
CARDMAGs2B$Sample=as.numeric( gsub("final*.*","", CARDMAGs2B$MAG))
CARDMAGs2B$Genes_No=as.numeric(CARDMAGs2B$Genes_No )

CARDMAGs2B=CARDMAGs2B%>%filter(
Domain=="Bacteria"& Completeness>80&Contamination<10)



firstup <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}

CARDMAGs2$DrugClass=sapply(CARDMAGs2$Drug.Class, function(x) firstup(x))
CARDplot= ggplot(CARDMAGs2, aes(y=DrugClass, x=Phylum, fill=Completeness))+
  geom_jitter(shape=21, size=10)+theme_bw()+theme(legend.position = "top")+
  scale_fill_distiller(palette = "RdBu", name="Completeness %")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold.italic", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="bold", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black"))+
  theme(legend.key.width = unit(2.5,"cm"))+
  ylab("Resistance to Drug Class")+xlab("")

CARDMAGsXX=data.frame(MAG=unique(stats_complete_mags2$MAG))
CARDMAGsXX$Sample=as.numeric( gsub("final*.*","",CARDMAGsXX$MAG))
CARDMAGsXX$Sample=as.numeric( gsub("final*.*","",CARDMAGsXX$MAG))
CARDMAGsXX=dcast(CARDMAGsXX, Sample~., value.var = "MAG", length)
CARDMAGsXX

CARDMAGsXX2=CARDMAGs2
CARDMAGsXX2$Sample=as.numeric( gsub("final*.*","",CARDMAGsXX2$MAG))
CARDMAGsXX2=dcast(CARDMAGsXX2, Sample~., value.var = "MAG", length)
CARDMAGsXX3=full_join(CARDMAGsXX2,CARDMAGsXX, by="Sample")
CARDMAGsXX3$gpg=CARDMAGsXX3$..x/CARDMAGsXX3$..y
CARDMAGsXX3$gpg[is.na(CARDMAGsXX3$gpg)]=0

ggsave(filename = paste0(pathMG, "ARGMAGs.png"), width = 35, height = 15)


MRG1=read.csv(paste0(pathMG,"MRG.csv"))

MRG1$MAG=gsub(".fa","", MRG1$bin)

MRG1MAGs=full_join( stats_complete_mags2,
                    MRG1, by="MAG")%>%na.omit()
MRG1MAG2=separate(MRG1MAGs, col = "Classification", into = c("Domain", "Phylum", "Class","Order"), sep = ";")%>%filter(Phylum!="NA")

MRG1MAG2=filter(MRG1MAG2, str_detect(Compound, "Pb|As|Cu|Ni|Mn"))
MRG1MAG2B=dcast(MRG1MAG2, Compound+Completeness+Contamination+ Domain+ Genes_No+MAG+Phylum~., value.var = "MAG", length) 
CARDMAGs2B$Sample=as.numeric( gsub("final*.*","", CARDMAGs2B$MAG))
CARDMAGs2B$Genes_No=as.numeric(CARDMAGs2B$Genes_No )

CARDMAGs2B=CARDMAGs2B%>%filter(
  Domain=="Bacteria"& Completeness>80&Contamination<10)


MRG1MAGplot= ggplot(MRG1MAG2, aes(y=Compound, x=Phylum, fill=Completeness))+
  geom_jitter(shape=21, size=10)+theme_bw()+theme(legend.position = "top")+
  scale_fill_distiller(palette = "RdBu", name="Completeness %")+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold.italic", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="bold", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black"))+
  theme(legend.key.width = unit(2.5,"cm"))+
  ylab("MRG class")+xlab("")
ggsave(filename = paste0(pathMG, "MRGMAGs.png"), width = 30, height = 10)

  
MRG1MAG3=filter(MRG1MAG2, MAG%in%c(CARDMAGs$MAG))




MGE1=read.csv(paste0(pathMG,"MGEbins.csv"))

MGE1$MAG=gsub(".fa","", MGE1$bin)

MGE1MAGs=full_join( stats_complete_mags2,
                    MGE1, by="MAG")%>%filter(Bin!="NA")
MGE1MAG2=separate(MGE1MAGs, col = "Classification", into = c("Domain", "Phylum", "Class","Order"), sep = ";")%>%filter(Phylum!="NA")

MGE1MAGplot= ggplot(MGE1MAG2, aes(y=V3, x=Phylum, fill=Completeness))+
  geom_jitter(shape=21, size=10)+theme_bw()+theme(legend.position = "top")+
  scale_fill_distiller(palette = "RdBu", name="Completeness %")+
  theme(axis.text.y = element_text( size=20, face="bold.italic", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold.italic", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="bold", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black"))+
  theme(legend.key.width = unit(2.5,"cm"))+
  xlab("")+ylab("HGT-Marker")

MGE1MAGplot
ggsave(filename = paste0(pathMG, "MGEMAGs.png"), width = 15, height = 5)


MAGs1=rbind(
select( CARDMAGs2, MAG, Phylum, Gene=CARD.Short.Name)%>%
  mutate(Type="ARG"),
select( MRG1MAG2, MAG, Phylum, Gene=Gene_name)%>%
  mutate(Type="MRG"),
select( MGE1MAG2, MAG, Phylum, Gene=V3)%>%
  mutate(Type="HGT-Marker")
)%>%select(MAG,Phylum,Gene,Type)

library(igraph)
g=graph_from_data_frame(MAGs1)
library(ggnetwork)
g1=ggnetwork(g)
g2=filter(stats_complete_mags3, MAG%in%c(g1$name))%>%
  select(name=MAG, Phylum,)

library(ggalluvial)
ggplot(MAGs1, aes(axis1=MAG, axis2=Type ))+geom_alluvium(aes(fill=Type))+
        geom_stratum(aes(fill=Phylum)) 

ggplot(MAGs1, aes(x=Phylum, y=Type ))+geom_jitter()
g1= full_join(select(CARDMAGs2, DrugClass=Drug.Class, ARG=`AMR.Gene.Family`, MAG, Phylum ),
          select(MRG1MAG2, MRG=Gene_name, Compound, MAG, Phylum ))%>%na.omit()

gg1=ggplot(g1, aes(axis1=DrugClass, axis2=Compound))+
geom_alluvium(aes( fill=Phylum))+theme_bw()+
  geom_stratum( fill = "white", color = "black", alpha=0.75) +
  geom_label(stat = "stratum", aes(label = after_stat(stratum)))+
  scale_fill_brewer(palette = "Paired")
gg1

g2= full_join(select(CARDMAGs2, DrugClass,Resistance.Mechanism, Class, Order, Family,Genus,  ARG=CARD.Short.Name, MAG, Phylum ),
              select(MRG1MAG2, MRG=Gene_name, Compound, MAG, Phylum ))%>%
  full_join(.,
              select(MGE1MAG2, HGTM="V3", Phylum, MAG) )%>%na.omit()



g2$MAG2=paste0("Sample",  gsub("SemiBin_","", gsub("final."," MAG",g2$MAG)))
gg2=ggplot(g2, aes(axis1=MAG2, axis2=ARG, axis3= DrugClass, axis4=HGTM, axis5=Compound))+
  geom_alluvium(aes( fill=paste0(Phylum,";", Class,";",
                                 Order,";", 
                                 Family,";",
                                 Genus)))+theme_bw()+
  geom_stratum( fill = "white", color = "black", alpha=0.95) +
  geom_label(stat = "stratum", aes(label = after_stat(stratum)))+
  scale_fill_brewer(palette = "Set1", name="")+theme_void()+
  theme(legend.text =  element_text( size=20, face="bold.italic", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black"),
        legend.position = "top")+guides(fill=guide_legend(ncol=1))
gg2
write.csv(g2, file = "TableS8.csv")
ggsave(filename = paste0(pathMG, "alluvial_ALL.png"), width = 15, dpi = 200, height = 5)

gMM= full_join(select(MRG1MAG2, MRG=Gene_name, Compound, MAG, Phylum),
                select(MGE1MAG2, HGTM="V3", Phylum, MAG) )%>%na.omit()


gXX= full_join(select(CARDMAGs2, Drug.Class, Class, Order, Family,Genus,  ARG=`AMR.Gene.Family`, MAG, Phylum ),
               
               select(MGE1MAG2, HGTM="V3", Phylum, MAG) )%>%na.omit()


stats1=data.frame(All=length(unique(g2$MAG)), "ARG & MRG"=length(unique(g1$MAG)),
                  "ARG & HGT-Markers"=length(unique(gXX$MAG)),
"MRG & HGT-Markers"=length(unique(gMM$MAG)),check.names = F)%>%
  t()%>%as.data.frame()
colnames(stats1)="MAG"
stats1$Group=rownames(stats1)
stats1$Group=factor(stats1$Group, levels = c(
"ARG & MRG","ARG & HGT-Markers","MRG & HGT-Markers", "All"))
NumberofMAGs= ggplot(stats1, aes(y=Group, x=MAG))+geom_bar(stat="identity",colour="black", fill="skyblue4")+xlim(0,40)+
  theme_bw()+
  theme(axis.text.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.text.x = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.y = element_text( size=20, face="bold", colour = "black"))+
  theme(axis.title.x = element_text( size=20, face="bold", colour = "black"))+
  theme(legend.text =  element_text( size=20, face="bold", colour = "black")) +
  theme(legend.title  =  element_text( size=25, face="bold", colour = "black"))+
  theme(legend.key.width = unit(2.5,"cm"))+
  ylab("")+xlab("Number of MAGs")

ggarrange(NumberofMAGs,gg2, font.label = list(size=20), labels = c("A)","B)"),
          ncol = 1)

ggsave(filename = paste0(pathMG, "NumberofMAGs.png"), width = 15, height = 10)



