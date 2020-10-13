#!/bin/bash

## General things for SAGA
#SBATCH --account=nn9408k
#SBATCH --job-name=alignment
#SBATCH --time=5-0:0:0
#SBATCH --mem-per-cpu=8G
#SBATCH --ntasks=6

## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default

## Load modules for this analysis
ml BWA/0.7.17-intel-2018b
ml SAMtools/1.9-intel-2018b

## set variables ##

# base directory for output files
OUTDIR=/cluster/work/users/josece/alignment

OMP_NUM_THREADS=6

# set reference
REF=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/the_genome/T_kauaiensis_ref.fasta

# get prefix from input
PREFIX=T_restricta_Maui_EM_lightbrown_BioinformaticID_071
SAMPLE=$(echo $PREFIX | awk -F "_" '{print $1"_"$2"_"$NF}')

#input folder
INPUT_FOLDER=/cluster/projects/nn9408k/cerca/010_tetragnatha/clean_data/02_trimmomatic/march2020_v2/

# paired
FORWARD=$INPUT_FOLDER/${PREFIX}_F.cleaned.fastq.gz
REVERSE=$INPUT_FOLDER/${PREFIX}_R.cleaned.fastq.gz
#unpaired
FORWARD_UNPAIR=$INPUT_FOLDER/${PREFIX}_F.cleaned_unpaired.fastq.gz
REVERSE_UNPAIR=$INPUT_FOLDER/${PREFIX}_R.cleaned_unpaired.fastq.gz

#set ID
ID=$(echo $PREFIX | awk -F "_" '{print $7}')

# set platform
PLATFORM=Illumina

# get library
LIBRARY=MA20

#get the sample
#SEE ABOVE - SAMPLE=${SAMPLE}

# extract PU data
PU_DATA=$(zcat $FORWARD | head -1 | cut -d ":" -f 3,4)

# construct read group
READGROUP="@RG\tID:${ID}\tPL:${PLATFORM}\tLB:${LIBRARY}\tSM:${SAMPLE}\tPU:${PU_DATA}"

# working directory
cd $SCRATCH

# map paired end
echo "Aligning $SAMPLE, paired-end"
bwa mem -M -t $OMP_NUM_THREADS \
-R $READGROUP \
$REF $FORWARD $REVERSE | samtools view -b | samtools sort -T ${PREFIX} > ${PREFIX}_pe.bam

# map unpaired - FORWARD
echo "Aligning $SAMPLE, unpaired, forward"
bwa mem -M -t $OMP_NUM_THREADS \
-R $READGROUP \
$REF $FORWARD_UNPAIR | samtools view -b | samtools sort -T ${PREFIX} > ${PREFIX}_up_forward.bam

# map unpaired - REVERSE
echo "Aligning $SAMPLE, unpaired, reverse"
bwa mem -M -t $OMP_NUM_THREADS \
-R $READGROUP \
$REF $REVERSE_UNPAIR | samtools view -b | samtools sort -T ${PREFIX} > ${PREFIX}_up_reverse.bam

## merge paired and unpaired
echo "Merging $SAMPLE bams"
samtools merge -rf ${PREFIX}_merge.bam \
${PREFIX}_pe.bam  ${PREFIX}_up_forward.bam ${PREFIX}_up_reverse.bam

# sort merged
echo "Sorting merged $SAMPLE bam"
samtools sort -T ${PREFIX} -o ${PREFIX}_merge_sort.bam ${PREFIX}_merge.bam

# rm unsorted
rm ${PREFIX}_merge.bam

# copy to outdir
echo "Copying $SAMPLE output"
mv ${PREFIX}_merge_sort.bam ${SAMPLE}.bam
rsync -ravz ${SAMPLE}.bam $OUTDIR
