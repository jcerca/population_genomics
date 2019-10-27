#27/10/2019
#José Cerca
This repository has instructions on how to run the program SNAPP https://www.beast2.org/snapp/  , included as part of BEAST2 http://www.beast2.org . 

Example data: blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf This is a variant call format file (VCF) with three species (blue - Stygocapitella subterranea, green - S. josemariobrancoi, purple - S. westheidei) which has been prunned for -r 0.50 (loci has to be present on 50% of a population), -p 8 (loci has to be present on at least 8 populations) on STACKS, and on 0.05 minimum allele frequency, 100 mean depth, 10 min depth on vcftools. After this, individuals with 90% missing data were removed, and only one SNP was kept per RAD-tag (notice, this is RADseq data, so each RADtag is considered as a chromossome).


1. Before we start
NOTE! Snapp can be very slow. My recommendation is that one retrieves a given number of random-SNPs from the variant call format. Let's say, 4000.
```
#first, we get the random.snps..
grep -v "^#" blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf | cut -f 1-3 | shuf | head -n 4000 | cut -f 3 > random.snps.tsv
#we grep out the header
# then we cut the first to the third fields, and shuffle them.
# we get the 4000 first lines, and get cut the chromossomes.

#Now we feed this to vcftools:
vcftools --vcf blue.green.purple.r50.p8.stacks.maf0.05.maxMeanDP100.minMeanDP10.indswith90missingnessRemoved.randomSNP.vcf --snps random.snps.tsv --recode --recode-INFO-all --out trimmed_for_analysis.vcf

#To select individuals you can do
bcftools -l trimmed_for_analysis.vcf
# and select individuals from this list. You can use:
vcftools --keep list_ofinds.tsv --vcf trimmed_for_analysis.vcf --recode --out --recode-INFO-all trimmed_for_analysis_v2.vcf
```

2. Formatting the vcf
```
# First, we need to convert the file to a nexus file.

perl vcf2nex.pl trimmed_for_analysis_v2.vcf > my_SNAPPinput.nex
```

3. Let's set-up the analyses on BEAST2 (Graphical user interface) - FYI I am using BEAST.v2.4.7.Windows

3.1 Open "BEAUTi"
3.2 On the top left, click "File", then "Manage packages", scroll down and select "SNAPP" and click "Install/Upgrade". Close and re-open BEAUTi to make sure it loads everything.
3.3 On the top left, click "File", then "Template", now it should appear one called "SNAPP". Let's get started!
3.4 On the top left, click "File", "Add alignment", select the nexus file we formatted in step 1.
3.5 You have to define species/populations manually. In this case, I defined species only. See snapp_example.png
      Please note:
      3.5.1. In my version, everytime I wrote the species name, it messed up the final file. The workaround I found was to just delete the species name and IDs, leaving only the "blue", "green", "purple". Windows can be quite cluncky in this aspect.
3.6 Click on "Model parameters", and "Calc mutation rates".
      3.5.2 If you have defined groups *only with a single individual*, the analysis will not run. Took me a while to find this.
      Important note:
      3.6.1 In my windows version it just says "infinite mutation rate". This will not allow the analyses to run. The workaround I found consisted in saving the file ("File", "Save"), re-opening it, going back to "Model parameters" and clicking "Calc mutation rates". Now you should not have "infinite".
3.7 Modify other parameters as you see fit.

4. Run SNAPP! Use the xml file provided by the interface.
```
beast -seed 223456 -threads 10 -beagle snapp.xml
```

5. If the analysis falls short in terms of the MCMC (i.e. you select 100.000 but it only runs for 50.000), you can resume analysis by:
```
beast -resume -seed 223456 -threads 10 -beagle snapp.xml
```

Suggestion: Try running my script and see what the commands are doing, that is data convertion and formating, and analysis. Then adapt it and run it on your own data. #extra file - cerca_snapp_onAbel.sh for a slurm example. Goodluck!
