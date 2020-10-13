#!/bin/bash
# Job name:
#SBATCH --job-name=genomicdb
## Project:
#SBATCH --account=nn9408k
# Wall clock limit (hh:mm:ss):
#SBATCH --time=300:00:00
## Processor and memory usage:
#SBATCH --mem-per-cpu=90G
#SBATCH --partition=bigmem
#SBATCH --ntasks=4

## set up job environment

module purge
module load GATK/4.1.4.0-GCCcore-8.3.0-Java-1.8

### Variables
REF=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/the_genome/T_kauaiensis_ref.fasta
GENODB=gendb:////cluster/work/users/josece/GenomicDB/gdb
referenceList=/cluster/work/users/josece/GenomicDB/reference.list

### Moving
cd /cluster/work/users/josece/GenotypeVCF

gatk GenotypeGVCFs \
    -R ${REF} \
    -V ${GENODB} \
    -L $referenceList \
    --include-non-variant-sites \
    -O ./all_spiders.AllSites.raw.vcf



#gatk GenotypeGVCFs \
#    -R ${REF} \
#    -V ${GENODB} \
#    -L $referenceList \
#    -O ./all_spiders.VariantSites.raw.vcf
