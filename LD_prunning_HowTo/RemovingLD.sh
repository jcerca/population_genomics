ml PLINK/1.9b_6.13-x86_64

VCF=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/06_CleaningVCF/04_finalVCF/all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.vcf.gz

plink --vcf $VCF --double-id \
--allow-extra-chr --set-missing-var-ids @:# --allow-no-sex --indep-pairwise 25 5 0.06 --out spider.prune

# extract the actual data
plink --vcf $VCF --double-id \
--allow-extra-chr --set-missing-var-ids @:# --extract spider.prune.in --make-bed \
--recode vcf --out all_spiders.VariantSites.maf0.02.miss0.25.qual30.mindepth5.maxdepth25.LDprunned0.06
