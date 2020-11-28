Much credit of this tutorial goes to Mark Ravinet, who kindly provided a previous version.

All is done in R, starting from a [vcf file](https://en.wikipedia.org/wiki/Variant_Call_Format). I provide an example on: PCA_stygo.R, and provide a walkthrough in this thread.


```
# Few notes before we start. The native format for adegenet is "genlight".
```

1. We start by cleaning up the space and setting the working directory. The working directory is the folder where you have your vcf file and where you want the plots to be saved.

```
#Clean up!
rm(list=ls())

#Set Working directory
setwd("C:/Users/Cerca/Desktop/ongoing_stuff_ambientedetrabalho/project3/02_PCA/")
````

2. We will load the libraries. If you haven't installed, you can use:
```install.packages("NameOfLibrary")```

```
#Load up those Libraries
library(vcfR)       #Data loading
library(adegenet)   #Data analysis
library(tidyverse)  #PCA
library(gridExtra)  #PCA
library(ape)        #Phylogenetic analyses
library(lemon)      #for the g_legend
```

3. We load the VCF file onto R. The VCF should be in your working directory (set up on step 1). We create an object called ```vcf_file```, and then convert it to a file named "genlight_file".
```
#Loading up the VCF
vcf_file<-read.vcfR("./blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf")
str(vcf_file) # checking if it went well

#Converting from vcf to genlight
genlight_file<-vcfR2genlight(vcf_file)
```

4. As a sanity check we can see loci missingness.
```
# Plotting missingness
glPlot(genlight_file, posi="topleft")
```

5. Let's just explore the data as a NJ tree.
```
# Neighbourjoining TREE
tre <- njs(dist(as.matrix(genlight_file)))
tre
plot(tre, typ="fan", cex=0.7)
title("NJ tree")
```

6. Now for the headliner, the PCA

```
# PCA
pca1 <- glPca(genlight_file)
4 #axis
```

5. Make sure you colour the PCA so it is easily interpreted. This part is specific to you and your dataset. What you need is to have a file which should look like the following:
(Notice you can get estimates of coverage and missing data per individual with vcftools)
```
Individuak<tab>Population<tab>Species<tab>coverage<tab>collectionDate<tab>missingdata
X01            Portugal       Passer01    30          Feb2018             0.04
X02            Portugal       Passer02    25          Feb2019             0.10
Y01            Norway         Passer01    28          Mar2018             0.03
Z01            Sweden         Passer01    30          Mar2018             0.50
...
```

6. We calculate the Percent of Variance explained:
```
# calculate PVE
pve <- (pca1$eig/sum(pca1$eig))*100
```

7. And we plot. Notice rthat the "colour" and the "pch" (shape of the symbols) should be whatever you set up on step 5.
```
a <- ggplot(temp, aes(PC1, PC2, colour = Population, pch=Species)) + geom_point() +
  xlab(paste0("PC1 (", signif(pve[1], 2), "%)")) + ylab(paste0("PC2 (", signif(pve[2], 2), "%)"))
a
b <- ggplot(temp, aes(PC1, PC3, colour = Population, pch=Species)) + geom_point() +
  xlab(paste0("PC1 (", signif(pve[1], 2), "%)")) + ylab(paste0("PC3 (", signif(pve[3], 2), "%)"))
b

c <- ggplot(temp, aes(PC2, PC3, colour = Population, pch=Species)) + geom_point() +
  xlab(paste0("PC2 (", signif(pve[2], 2), "%)")) + ylab(paste0("PC3 (", signif(pve[3], 2), "%)"))
c

d <- ggplot(temp, aes(PC1, PC4, colour = Population, pch=Species)) + geom_point() +
  xlab(paste0("PC1 (", signif(pve[1], 2), "%)")) + ylab(paste0("PC4 (", signif(pve[4], 2), "%)"))
d

pdf("pca.pdf", width = 11, height = 8.5, pointsize = 10, family = "Helvetica")
a
b
c
d
dev.off()
