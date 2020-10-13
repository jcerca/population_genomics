#!/bin/bash
# Job name:
#SBATCH --job-name=genomicdb
## Project:
#SBATCH --account=nn9201k
# Wall clock limit (hh:mm:ss):
#SBATCH --time=300:00:00
## Processor and memory usage:
#SBATCH --mem-per-cpu=90G
#SBATCH --nodes=2
#SBATCH --partition=bigmem
##SBATCH --mem-per-cpu=10000M
## set up job environment

module purge
module load GATK/4.1.4.0-GCCcore-8.3.0-Java-1.8

cd /cluster/work/users/josece/GenomicDB
genomicsdb=/cluster/work/users/josece/GenomicDB
tmp=/cluster/work/users/josece/tmp

awk '{print $1 ":1-" $2}' /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/the_genome/T_kauaiensis_ref.fasta.fai > reference.list
# reference_intervals=/cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/04_GenomicsDB/reference.list

#make db for all gvcf
gatk GenomicsDBImport \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_anuenue_046_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_anuenue_047_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_anuenue_048_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_anuenue_049_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_anuenue_060_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_anuenue_066_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_brevignatha_007_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_brevignatha_050_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_brevignatha_062_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_brevignatha_067_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_filiciphila_074_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_filiciphila_075_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_001_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_008_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_009_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_010_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_011_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_012_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_013_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_014_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_015_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kamakou_068_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kauaiensis_016_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kauaiensis_017_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kauaiensis_018_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kauaiensis_019_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kauaiensis_020_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_kikokiko_072_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_macracantha_073_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_macracantha_076_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_mohihi_021_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_mohihi_022_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_mohihi_023_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_mohihi_051_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_mohihi_052_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_perreirai_024_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_perreirai_025_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_perreirai_026_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_perreirai_027_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_perreirai_061_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_pilosa_028_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_pilosa_029_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_pilosa_030_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_pilosa_031_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_pilosa_032_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_polychromata_053_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_polychromata_054_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_polychromata_055_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_polychromata_056_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_polychromata_057_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_002_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_003_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_004_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_005_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_006_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_033_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_034_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_035_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_036_raw.g.vcf \

-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_058_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_063_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_064_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_quasimodo_065_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_restricta_037_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_restricta_038_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_restricta_069_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_restricta_070_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_restricta_071_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_tantalus_039_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_tantalus_040_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_waikaimoi_059_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_waikamoi_041_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_waikamoi_042_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_waikamoi_043_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_waikamoi_044_raw.g.vcf \
-V /cluster/projects/nn9408k/cerca/010_tetragnatha/analyses/pop_genomics/01_datageneration/03_HapCaller/files/T_waikamoi_045_raw.g.vcf \
--genomicsdb-workspace-path ./gdb --tmp-dir=$tmp  --intervals reference.list
