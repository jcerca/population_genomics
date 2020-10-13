#!/bin/bash

module load picard-tools
module load samtools

ref_folder=/usit/abel/u1/josece/007_bowhead/4_alldata/0_ref
ref=$ref_folder/scaffolds_referencegenome.fasta

java -jar $PICARD_JAR CreateSequenceDictionary R=$ref O=$ref_folder/scaffolds_referencegenome.dict
samtools faidx $ref
