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

# Third, and very important, we have a file with various rows. Starting from the third row, we have our individuals.
# Column one will have individuals, column two will have a "random" number, and columns three-til the end will have allelic information.
# TO-DO: In COLUMN TWO, change the numbers to correspond to populations. In this dataset, I changed all blue individuals to "1", all purple to "2" and all green to "3".

# Forth, remove the second row.
grep -v "^\-1" my_vcf_structure.str > final_structure_file.str
```

3. Getting the parameters files' 
```
# There are two parameter files: mainparams and extraparams. Open the main params
nano mainparams
# Now, we need to change some rows.

#define MAXPOPS     2         ### represents the numbers of clusters to run. STRUCTURE analyses are typically run for K1:Kn+1. K1 = single population, K2 = two populations.. Kn+1 = N+1 populations. In reality, I defined three species (blue, green, purple), so I will run from K1 til K4. Why K1? Because we will need to evaluate the fit of every analyses. I'll explain below.

#define NUMINDS    70         ### Here you add the number of individuals - 70 in this casse.
#define NUMLOCI    3428       ### Here you add the number of SNPs - 3428 in this case.

# How do I know? Well, you can use:
bcftools query -l blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf | wc -l # for individuals

#Or you can use:
vcftools --vcf --missing-site
#which prints:
#After filtering, kept 70 out of 70 Individuals
#After filtering, kept 3428 out of a possible 3428 Sites
```

5. Run structure!
```
structure -m mainparams -e extraparams -i final_structure_file.str -o ./
```

6. Running structure:
You should run each K at least 5 times to make sure you get congruent results. Structure implements a Bayesian MCMC and sometimes the chain can get "stuck" on the wrong state.

7. Plotting and deciding the best K
I use http://clumpak.tau.ac.il/ to plot, and to estimate the best K http://clumpak.tau.ac.il/bestK.html .

Suggestion:
Try running my script and see what the commands are doing, that is data convertion and formating, and analysis. 
Then adapt it and run it on your own data.
#extra file - cerca_structure_onAbel.sh for a slurm example. Goodluck!
