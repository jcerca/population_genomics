 #Few notes. The native format for adegenet is "genlight".
#Useful tutorial from Filip Kolar which goes from vcf to genlight directly.
#Filip's tutorial  https://botany.natur.cuni.cz/hodnocenidat/Lesson_05_tutorial.pdf

#Clean up!
rm(list=ls())

#Set Working directory
setwd("C:/Users/Cerca/Desktop/tmp/")

#Load up those Libraries
library(vcfR)       #Data loading
library(adegenet)   #Data analysis
library(tidyverse)  #PCA
library(gridExtra)  #PCA
library(ape)        #Phylogenetic analyses
library(lemon)      #for the g_legend

#Loading up the VCF
vcf_file<-read.vcfR("all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06.vcf")
str(vcf_file)

#Converting from vcf to genlight
genlight_file<-vcfR2genlight(vcf_file)

###################################################################################################################
#Loci missingness

# Plotting missingness
glPlot(genlight_file, posi="topleft")


###### Neighbourjoining TREE
tre <- njs(dist(as.matrix(genlight_file)))
tre
plot(tre, typ="fan", cex=0.7)
title("Tree")

identify(tre, nodes = TRUE) # click on T. filiciphila
# Node 148

newtre<-root(tre, node=148)
plot(newtre, typ="fan", cex=0.7)
