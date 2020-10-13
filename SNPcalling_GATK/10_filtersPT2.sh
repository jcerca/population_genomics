ml vcflib/1.0.1-GCC-8.3.0

### The "-r" value is obtained by:
### (number_of_snps_wanted*100)/total_nr_of_SNPs
vcfrandomsample -r 0.0010859582899927 all_spiders.VariantSites.raw.onlySNPs.SpanningDelesionsRemoved.vcf > all_spiders.VariantSites.raw.onlySNPs.SpanningDelesionsRemoved.100000snpSUBSET.vcf


vcf="../all_spiders.VariantSites.raw.onlySNPs.SpanningDelesionsRemoved.100000snpSUBSET.vcf"
subset=tetragnatha_subset

# We calculate allele frequency
vcftools --vcf $vcf --freq2 --out $subset --max-alleles 2

# We calculate mean depth per individual
vcftools --vcf $vcf --depth --out $subset

# We calculate mean depth per site
vcftools --vcf $vcf --site-mean-depth --out $subset

# We calculate site quality
vcftools --vcf $vcf --site-quality --out $subset

# We calculate the proportion of missing data per individual
vcftools --vcf $vcf --missing-indv --out $subset

# We calculate the proportion of missing data per site
vcftools --vcf $vcf --missing-site --out $subset

# We calculate the heterozygosity and inbreeding coefficient
vcftools --vcf $vcf --het --out $subset


#### Now we're going to R :)
