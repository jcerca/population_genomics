# 27/10/2019
# José Cerca

This repository has instructions on how to run the program STRUCTURE in the terminal.
version:

```
structure -h
```

STRUCTURE by Pritchard, Stephens and Donnelly (2000)
     and Falush, Stephens and Pritchard (2003)
       Code by Pritchard, Falush and Hubisz
             Version 2.3.2.1 (Oct 2009)


1. Example data:
blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf
This is a variant call format file (VCF) with three species (blue - Stygocapitella subterranea, green - S. josemariobrancoi, purple - S. westheidei) which has been prunned for -r 0.50 (loci has to be present on 50% of a population), -p 8 (loci has to be present on at least 8 populations) on STACKS, and on 0.05 minimum allele frequency, 100 mean depth, 10 min depth on vcftools. After this, individuals with 90% missing data were removed.

2. script
PCA_stygo.R
This contains a script to do PCA based on genomic data (vcf).

3. Suggestion:
Try running my script and see what the commands are doing, that is data convertion and formating, and analysis. 
Then adapt it and run it on your own data.
