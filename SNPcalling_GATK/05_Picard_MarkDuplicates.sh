#!/bin/bash

## General things for SAGA
#SBATCH --account=nn9408k
#SBATCH --job-name=duplicates
#SBATCH --time=4-0:0:0
#SBATCH --mem-per-cpu=30G
#SBATCH --ntasks=1

## Set up job environment
source /cluster/bin/jobsetup
module purge

# Load em up
ml GATK/4.1.4.0-GCCcore-8.3.0-Java-1.8

##Edit sample name
sample=T_quasimodo_006

ref=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/the_genome/T_kauaiensis_ref.fasta
#picard_output_folder=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/02_picard
bam_file=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/01_alignment/files/${sample}.bam

cd /cluster/work/users/josece/picard/
TMP=`pwd`/tmp

## Do some work:

# first sort using PICARD
echo "### Running Picard sort on $sample ###"
gatk SortSam \
--INPUT=${bam_file} \
--OUTPUT=${sample}_sort.bam \
--SORT_ORDER=coordinate --TMP_DIR=$TMP

# then mark duplicates
echo "### Running Picard MarkDuplicates on $sample ###"
gatk MarkDuplicates \
--INPUT=${sample}_sort.bam \
--OUTPUT=${sample}_sort_dedup.bam \
--METRICS_FILE=${sample}_dedup_metrics.txt

# index bams using PICARD
echo "### Running Picard sort on $sample ###"
gatk BuildBamIndex \
--INPUT=${sample}_sort_dedup.bam
