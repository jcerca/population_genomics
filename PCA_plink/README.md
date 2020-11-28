The PCA using R can be very slow if you have many variants or many samples. I therefore generally recommend using plink, starting from a vcf file. I provide an example on above with the .sh and the R. script and walk you through it here.

1. We do the PCA using plink. The flag ```-vcf``` specifies the vcf file. ```-pca``` The number of dimensions you want for your pca, and ```-out``` the output file. The remaining flags are plink-specific flags. We use them before plink was built for human-biologists and plink expects to see 23 chromossomes.

```
myVCF=all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06.vcf

plink -vcf $myVCF \
--pca 6 \
--out ${myVCF}.PCA \
--double-id --allow-extra-chr --set-missing-var-ids @:# --allow-no-sex
```

2. Now onto R! We start by loading libraries and by setting our working directory, which will be different for each of us.

```
library(tidyverse)
setwd("C:/Users/Cerca/Desktop/tmp/")
```

3. Now we read the eigenvec file generated with plink (step 1) and rename the headers. Notice that if you used fewer dimensions (e.g. --pca 4) or more (e.g. --pca 10), you'll need to adjust the number of "PC" in the "colnames".
```
myData<-read_table2("all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06.PCA.eigenvec", col_names =F)
colnames(myData) <- c("ID","IDrep","PC1","PC2","PC3","PC4","PC5", "PC6")

```

4. Now we add a table with data for the PCA. This should consist of a tab-separated format with information you want. It must feature the specimens ids, that were used for plink. It should look like this.

```
ID<tab>Population<tab>Species<tab>coverage
X01            PT             Passer      29
X02            PT             Passer      30
...
```

OK - for step 4:
```
variables<-read_table2("data_for_PCA.txt")
```

5. Now, you can merge myData and the PCA variables using tidyverse's "merge". This will merge the data based on the individual IDs.
```
df<- merge(myData, variables, by = "ID")
```

6. Now we plot!
```
# Note - The eigenvalues for PC1 : 15.4827 (rounded 15.5)
# for PC2: 12.8583 (rounded 12.9)
# These values are provided in plink (step 1) on the *eigenval file

# Exploring major axis
ggplot(df, aes(PC1, PC2, colour=species, pch=radiation)) +
  geom_point(size=3, aes(fill=species)) +
  theme_minimal() +
  xlab("PC1 (15.5%)") +
  ylab("PC2 (12.9%)") 
```
