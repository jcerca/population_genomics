# 27/10/2019
# José Cerca

This repository has instructions on how to run the program STRUCTURE in the terminal.
version:

```
structure -h

STRUCTURE by Pritchard, Stephens and Donnelly (2000)
     and Falush, Stephens and Pritchard (2003)
       Code by Pritchard, Falush and Hubisz
             Version 2.3.2.1 (Oct 2009)
```

1. Example data:
blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf
This is a variant call format file (VCF) with three species (blue - Stygocapitella subterranea, green - S. josemariobrancoi, purple - S. westheidei) which has been prunned for -r 0.50 (loci has to be present on 50% of a population), -p 8 (loci has to be present on at least 8 populations) on STACKS, and on 0.05 minimum allele frequency, 100 mean depth, 10 min depth on vcftools. After this, individuals with 90% missing data were removed, and only one SNP was kept per RAD-tag (notice, this is RADseq data, so each RADtag is considered as a chromossome).

2. Formatting the vcf
```
# First, we need to add a digit in front of the chromossome. This is RADseq data, and hence chromossome will correspond to the STACKS' number.

sed '/^#/! s/^/c/g' blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf > input_for_structure.vcf

# Second, we use plink v1.96 to recode to structure
plink --vcf input_for_structure.vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --out my_vcf_structure --recode structure

# Third, and very important, we have a file with various rows. Starting from the third row, we have individuals.
# Column one will have individual_ID, column two will have a consecutive number (1..2..3..N_inds), column 3 and all the remaining have allelic information.
# TO-DO: In COLUMN TWO, change the numbers to correspond to populations. In this dataset, I changed all blue individuals to "1", all purple to "3" and all green to "2". See "Structure_example.PNG

# Forth, remove the second row.
grep -v "^\-1" my_vcf_structure.str > final_structure_file.str
```

Suggestion:
Try running my script and see what the commands are doing, that is data convertion and formating, and analysis. 
Then adapt it and run it on your own data.
