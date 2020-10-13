#!/bin/bash

plink -vcf all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06 --pca 6 --out all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06.PCA --double-id --allow-extra-chr --set-missing-var-ids @:# --allow-no-sex
