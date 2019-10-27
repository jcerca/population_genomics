#!/bin/bash

# Job name:
#SBATCH --job-name=oh.SNAPP
#
# Project:
#SBATCH --account=nn9408k
# Wall clock limit:
#SBATCH --time=167:00:00
#
# Max memory usage per core (MB):
#SBATCH --mem-per-cpu=6G
#
# Number of cores:
#SBATCH --cpus-per-task=10

## Set up job environment
source /cluster/bin/jobsetup
module purge
set -o errexit
module load beast2
module load beagle

snappfile=/usit/abel/u1/josece/003_amphilophus_radseq/2_20190319_newdata/11_SNAPP/2_VCF_with_only4000snps_indsRemoved/trimmed.indsRemoved.xml
filename=$(echo $snappfile | awk -F "/" '{print $10}')

source=/usit/abel/u1/josece/003_amphilophus_radseq/2_20190319_newdata/11_SNAPP/2_VCF_with_only4000snps_indsRemoved/run3/first_run_1week/

## Do some work:
cd $SCRATCH
chkfile "."
cp $source/* .

beast -resume -seed 223456 -threads $OMP_NUM_THREADS -beagle $filename
