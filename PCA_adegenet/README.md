# 23/09/2019
# José Cerca
Much credit of this script goes to Mark Ravinet, who kindly provided a previous version.

1. Example data:
blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf
This is a variant call format file (VCF) with three species (blue - Stygocapitella subterranea, green - S. josemariobrancoi, purple - S. westheidei) which has been prunned for -r 0.50 (loci has to be present on 50% of a population), -p 8 (loci has to be present on at least 8 populations) on STACKS, and on 0.05 minimum allele frequency, 100 mean depth, 10 min depth on vcftools. After this, individuals with 90% missing data were removed.

2. script
PCA_stygo.R
This contains a script to do PCA based on genomic data (vcf).

3. Suggestion:
Try running my script and see what the commands are doing, that is data convertion and formating, and analysis. 
Then adapt it and run it on your own data.
