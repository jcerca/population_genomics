#!/bin/bash

## General things for SAGA
#SBATCH --account=nn9408k
#SBATCH --job-name=alignment
#SBATCH --time=1:0:0
#SBATCH --mem-per-cpu=8G
#SBATCH --ntasks=1

## Set up job environment:
set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default

## Load modules for this analysis
ml SAMtools/1.9-intel-2018b

# get prefix from input
PREFIX=T_waikamoi_Maui_WM_green_BioinformaticID_045

FOLDER=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/01_alignment/mapping_quality

cd $FOLDER
samtools flagstat ../${PREFIX}_merge_sort.bam > $PREFIX.MappingQuality.stats
