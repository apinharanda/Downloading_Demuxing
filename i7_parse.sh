#!/bin/sh

PARSEDIR="/moto/palab/users/apinharanda/DyakIntrogression/raw_reads/i5_15"

pushd "${PARSEDIR}"
#divideConquerParser.sh [# input FASTQ files] [quoted space-separated list of FASTQ files] \
#[# parts to split into] [barcodes TSV file] [# to pass to --idxread] [# of mismatches to allow]
#Note: # of mismatches to allow will default to 0 if not provided.

#Specify the path to the ParsingPipeline:
PIPELINEDIR="/moto/palab/users/apinharanda/bin/ParsingPipeline-master"

NUM_THREADS=8 #ALWAYS MATCH THIS TO THE VALUE OF --cpus-per-task

NUM_READFILES=4 #ADJUST THIS TO MATCH HOW MANY OF THE R# VARIABLES ARE SET

READFILE_PREFIX="i5_15_read"

#Note: You may comment out any of these variables that you don't need,
# although you do need at least two: a read file, and an index read file
R1="${READFILE_PREFIX}_1.fastq.gz"
R2="${READFILE_PREFIX}_2.fastq.gz"
R3="${READFILE_PREFIX}_3.fastq.gz" #USE THIS ONLY IF YOU HAVE DUAL-INDEXED LIBRARIES
R4="${READFILE_PREFIX}_4.fastq.gz" #USE THIS ONLY IF YOU HAVE PAIRED-END LIBRARIES


I7INDICES="i7_barcodes.tsv" #Your customized version of i5_indices_template.tsv

PARSEREAD=2 #USE 2 IF YOU ARE PARSING i7, USE 3 IF YOU ARE PARSING i5
#Note that 2 and 3 only correspond to i7 and i5 if you place the i7 and i5
# read files as being the R2 and R3 variables.

NUM_MISMATCHES=1 #MAY SET TO 1, CHECK YOUR INDEX READ HISTOGRAM TO BE SURE 2 IS SAFE

bash ${PIPELINEDIR}/divideConquerParser.sh ${NUM_READFILES} "${R1} ${R2} ${R3} ${R4}" ${NUM_THREADS} ${I7INDICES} ${PARSEREAD} ${NUM_MISMATCHES}
popd