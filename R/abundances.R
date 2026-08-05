

#Multiple logistic regressions

multiple_glm= function(x){
  
  file1$Treatment2=file1$BMc
  file1$Treatment2[file1$Treatment2=="BMc"]<-1
  file1$Treatment2[file1$Treatment2=="Ctrl"]<-0
  file1$Treatment2=as.numeric(  file1$Treatment2)
  
  
  Table_glm=glm(file1$Treatment2~scale(x), family=binomial(link="logit"))
  file2=anova(Table_glm, test = "Chisq")
  FC1=dcast(data.frame(T=file1$BMc, A=x), T~., value.var = "A",  mean)
  FC2=log2((FC1[1,2]+1)/(FC1[2,2]+1))
  file3=data.frame(coeff=(Table_glm$coefficients[2]), p=file2$`Pr(>Chi)`[2], FC=FC2, Mean=mean(x))
  
  return(file3)
}


comparison_list=list()
for (i in unique(paste0( metadata_RH$Tillage,"_", metadata_RH$Int,"_", metadata_RH$Year ))){
  print(i)
  file1=mutate(metadata_RH, Group=paste0( metadata_RH$Tillage,"_", metadata_RH$Int, "_", metadata_RH$Year))
  file1=filter(file1, Group==paste0(i) )
  input1=(as.data.frame(t(ASV_table)[file1$ID,]))
  input2=as.data.frame( apply(input1, 2, function (x) sum(x>0)))
  colnames(input2)<-"Count"
  input2=filter(input2, Count>3)
  input3=as.data.frame(( input1[file1$ID,rownames(input2)]))
  multiple_glms_2020_ASVs= apply(input3,2, function(x) multiple_glm(x))
  multiple_glms_ASVs_df <- as.data.frame(do.call(rbind, multiple_glms_2020_ASVs))
  multiple_glms_ASVs_df[is.na(multiple_glms_ASVs_df)]<-1
  multiple_glms_ASVs_df$padj=p.adjust(multiple_glms_ASVs_df$p, method="BH")
  multiple_glms_ASVs_df=filter(multiple_glms_ASVs_df)%>%mutate(Int=unique(file1$Int),
                                                               Tillage=unique(file1$Tillage), Year=unique(file1$Year))
  comparison_list=rbind(multiple_glms_ASVs_df%>%rownames_to_column(var="ASV"),comparison_list)
  
}
