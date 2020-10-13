library(tidyverse)
setwd("C:/Users/Cerca/Desktop/tmp/")

myData<-read_table2("all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06.PCA.eigenvec", col_names =F)
colnames(myData) <- c("ID","IDrep","PC1","PC2","PC3","PC4","PC5", "PC6","PC7")

variables<-read_table2("data_for_PCA.txt")

df<- merge(myData, variables, by = "ID")


### Note - The eigenvalues for PC1 : 15.4827 (rounded 15.5)
### for PC2: 12.8583 (rounded 12.9)

### Exploring major axis
ggplot(df, aes(PC1, PC2, colour=species, pch=radiation)) +
  geom_point(size=3, aes(fill=species)) +
  theme_minimal() +
  xlab("PC1 (15.5%)") +
  ylab("PC2 (12.9%)") 
