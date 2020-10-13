#!/bin/bash

module load bwa

ref_folder=/usit/abel/u1/josece/007_bowhead/4_alldata/0_ref
ref=$ref_folder/scaffolds_referencegenome.fasta

bwa index $ref &> bwa_index.oe
