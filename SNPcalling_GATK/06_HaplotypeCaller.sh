#!/bin/bash

## General things for SAGA
#SBATCH --account=nn9408k
#SBATCH --job-name=snpCall
#SBATCH --time=6-0:0:0
#SBATCH --mem-per-cpu=30G
#SBATCH --ntasks=20

## Set up job environment
source /cluster/bin/jobsetup
module purge

# Load em up
ml GATK/4.1.4.0-GCCcore-8.3.0-Java-1.8

##Edit sample name
sample=T_kamakou_Maui_EM_maroon_BioinformaticID_001


#Fixed variables for Tetragnatha in SAGA
ref=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/the_genome/T_kauaiensis_ref.fasta
bam=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/02_picard/files/${sample}_sort_dedup.bam

cd /cluster/work/users/josece/HapCall

## RUN GATK HAPLOTYPE CALLER ###
# Perform Haplotype calling

echo "### Calling variants for $sample ###"
gatk HaplotypeCaller \
-R $ref \
-I $bam \
--emit-ref-confidence GVCF \
-O ${sample}_raw.g.vcf
