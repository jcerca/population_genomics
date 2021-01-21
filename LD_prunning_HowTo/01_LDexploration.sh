#!/bin/bash

## General things for SAGA
#SBATCH --account=nn9201k
#SBATCH --job-name=plink
#SBATCH --time=2-0:0:0
#SBATCH --mem-per-cpu=1G
#SBATCH --ntasks-per-node=1

## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default

## Load modules for this analysis
ml PLINK/1.9b_6.13-x86_64

VCF=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/06_CleaningVCF/04_finalVCF/all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.vcf.gz


# Notice the window size and the window jump
plink --vcf $VCF --recode --allow-extra-chr \
--const-fid 0 --allow-no-sex --r2 --ld-window 100 --ld-window-kb 100 \
--ld-window-r2 0 --out LD_decay_Tetragnatha


gzip LD_decay_Tetragnatha.ld

#Now, let's get a file for R.
awk '{print $7 "\t" $5-$2}' ../01_LDprunning/LD_decay_Tetragnatha.ld > ld.tetragnatha.tsv

# Print column 7 (R2)
# add a tab
# Print column 5 minus column two (gives you distance between 2 snps)
# Now we move to R.
