#!/bin/bash
# Job name:
#SBATCH --job-name=str.styg
#
#Project:
#SBATCH --account=nn9408k
#
# Wall clock limit:
#SBATCH --time=100:00:00
#
# Max memory usage per core (MB):
#SBATCH --mem-per-cpu=6G
#
# Number of cores:
#SBATCH --cpus-per-task=8

## Set up job environment:
source /cluster/bin/jobsetup    #mandatory code
module purge   # clear any inherited modules
set -o errexit # exit on errors
module load structure/2.3.3     #load structure

K=K5
main_directory=/usit/abel/u1/josece/006_stygo_RADseq_ultimate_only3clades/03_structure
#Note, inside $main_directory you should have a list of folders with K
# ls $main_directory should have: 1_file_conversion, K1, K2, K3, K4, K5

K_folder=$main_directory/$K
INPUTfolder=/usit/abel/u1/josece/006_stygo_RADseq_ultimate_only3clades/03_structure/1_file_conversion/
input=$INPUTfolder/final_structure_file.str

chkfile "." # ABEL-specific command
## Run command

cd $K_folder
mkdir run_${SLURM_JOBID}

cd run_${SLURM_JOBID}
structure -m $K_folder/mainparams -e $K_folder/extraparams -i $input -o ./run_K${K:(-1)}_${SLURM_JOBID} -K ${K:(-1)}
