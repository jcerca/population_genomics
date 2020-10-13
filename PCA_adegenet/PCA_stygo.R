###Data_analysis
#23_09_2019 JoseCerca

# Few notes. The native format for adegenet is "genlight".
# Useful tutorial from Filip Kolar which goes from vcf to genlight directly.
# Filip's tutorial  https://botany.natur.cuni.cz/hodnocenidat/Lesson_05_tutorial.pdf

#Clean up!
rm(list=ls())

#Set Working directory
setwd("C:/Users/Cerca/Desktop/ongoing_stuff_ambientedetrabalho/project3/02_PCA/")

#Load up those Libraries
library(vcfR)       #Data loading
library(adegenet)   #Data analysis
library(tidyverse)  #PCA
library(gridExtra)  #PCA
library(ape)        #Phylogenetic analyses
library(lemon)      #for the g_legend

#Loading up the VCF
vcf_file<-read.vcfR("./blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf")
str(vcf_file)

#Converting from vcf to genlight
genlight_file<-vcfR2genlight(vcf_file)

###################################################################################################################
#Loci missingness

# Plotting missingness
glPlot(genlight_file, posi="topleft")


#Second allele frequences
myFreq <- glMean(genlight_file)
hist(myFreq, proba=TRUE, col="gold", xlab="Allele frequencies",
     main="Distribution of (second) allele frequencies")
temp <- density(myFreq)
lines(temp$x, temp$y*1.8,lwd=3)
# Gaussian distribution.

#Allele frequences
myFreq <- glMean(genlight_file)
myFreq <- c(myFreq, 1-myFreq)
hist(myFreq, proba=TRUE, col="darkseagreen3", xlab="Allele frequencies",
     main="Distribution of allele frequencies", nclass=20)
temp <- density(myFreq, bw=.05)
lines(temp$x, temp$y*2,lwd=3)
#text(0.35, 2.5, "X",cex=4)
#text(0.7, 2.5, "X",cex=4)
#text(0.5, 1, "Happy graphic is happy",cex=2)
#A large number of loci are nearly fixed (frequencies close to 0 or 1)

###### Neighbourjoining TREE
tre <- njs(dist(as.matrix(genlight_file)))
tre
plot(tre, typ="fan", cex=0.7)
title("")


#######################################################################################   PCA!
pca1 <- glPca(genlight_file)
4 #axis

#CONVERTING THE PCA'S RESULTS TO A DATA_FRAME AND MANUALLY MAKING THE PLOT.

#Notice, this part of the script is pretty specific to the way I named files.
#It basically modifies the names following underscores and gets a "clade" identify and a "population" identity.

temp<-rownames_to_column(as.data.frame(pca1$scores),"rownames") #passing the row names to the first column
temp$LAB_ID<-temp$rownames #copying the first column to last

temp$pop<-word(temp$LAB_ID,1,sep="_")
temp$clade<-word(temp$LAB_ID,-2,sep="_")


# calculate PVE
pve <- (pca1$eig/sum(pca1$eig))*100


a <- ggplot(temp, aes(PC1, PC2, colour = pop, pch=clade)) + geom_point() +
  xlab(paste0("PC1 (", signif(pve[1], 2), "%)")) + ylab(paste0("PC2 (", signif(pve[2], 2), "%)"))
a
b <- ggplot(temp, aes(PC1, PC3, colour = pop, pch=clade)) + geom_point() +
  xlab(paste0("PC1 (", signif(pve[1], 2), "%)")) + ylab(paste0("PC3 (", signif(pve[3], 2), "%)"))
b

c <- ggplot(temp, aes(PC2, PC3, colour = pop, pch=clade)) + geom_point() +
  xlab(paste0("PC2 (", signif(pve[2], 2), "%)")) + ylab(paste0("PC3 (", signif(pve[3], 2), "%)"))
c

d <- ggplot(temp, aes(PC1, PC4, colour = pop, pch=clade)) + geom_point() +
  xlab(paste0("PC1 (", signif(pve[1], 2), "%)")) + ylab(paste0("PC4 (", signif(pve[4], 2), "%)"))
d

pdf("pca.pdf", width = 11, height = 8.5, pointsize = 10, family = "Helvetica")
a
b
c
d
dev.off()
