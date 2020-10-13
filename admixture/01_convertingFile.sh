conda activate plink
plink --vcf capeVerdesparrows.r60.maf0.01.minDepth3.maxDepth10.IndsWith30PercentMissingRemoved.chrIDchanged.LDprunned0.10.vcf --recode12 --out admixture.input --allow-extra-chr --double-id --make-bed



#### In admixture chromossomes need to be numerical, so I will remove all letters
### Example for this dataset
sed -i "s/^x[a-z]*// ; s/^Z/999999999/ ; s/^1A/999999998/; s/^LGE22/999999997/" admixture.input.bim

