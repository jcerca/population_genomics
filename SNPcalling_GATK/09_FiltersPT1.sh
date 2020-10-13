#!/bin/bash

## General things for SAGA
#SBATCH --account=nn9201k
#SBATCH --job-name=vcf_SNPs
#SBATCH --time=2-0:0:0
#SBATCH --mem-per-cpu=6G
#SBATCH --ntasks-per-node=1 --nodes=1

## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default

## Load modules for this analysis

# OK - from GATK I know we have 589,014,257 variants. We want a subset of 100,000 to check quality and filters..
# Many of these are Indels.
# Let's only get SNPs

ml VCFtools/0.1.16-intel-2018b-Perl-5.28.0
vcftools --gzvcf all_spiders.VariantSites.raw.vcf.gz --remove-indels --recode --recode-INFO-all --out all_spiders.VariantSites.raw.onlySNPs


ml BCFtools/1.10.2-iccifort-2019.5.281

bcftools view -V indels -e 'ALT="*" | N_ALT>1' all_spiders.VariantSites.raw.onlySNPs.vcf > all_spiders.VariantSites.raw.onlySNPs.SpanningDelesionsRemoved.vcf
bcftools view -H all_spiders.VariantSites.raw.onlySNPs.SpanningDelesionsRemoved.vcf | wc -l
