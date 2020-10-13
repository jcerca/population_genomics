#!/bin/bash

## Load modules for this analysis
ml VCFtools/0.1.16-intel-2018b-Perl-5.28.0

MAF=0.02
MISS=0.75
QUAL=30
MIN_DEPTH=5
MAX_DEPTH=25

VCF_OUT=all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.vcf.gz

vcftools --gzvcf all_spiders.VariantSites.raw.onlySNPs.SpanningDelesionsRemoved.vcf.gz  \
--maf $MAF --max-missing $MISS --minQ $QUAL \
--min-meanDP $MIN_DEPTH --max-meanDP $MAX_DEPTH \
--minDP $MIN_DEPTH --maxDP $MAX_DEPTH --recode --stdout | gzip -c > \
$VCF_OUT
