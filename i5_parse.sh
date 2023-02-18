#!/bin/sh
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8	##Make sure --cpus-per-task=8 matches NUM_THREADS below:
#SBATCH --mem=64000 ##64 GB RAM is usually plenty for 8 threads of parsing for HiSeq 2500, 4000, or X lanes
#SBATCH -J i5PARSE ##the namee of the job
#SBATCH -t 24:00:00 ##24 hours is usually plenty for parsing
#SBATCH --account=palab      ##The account name for the job

#add parsing directory
PARSEDIR="[add full dir]/i5parse"
pushd "${PARSEDIR}"
#divideConquerParser.sh [# input FASTQ files] [quoted space-separated list of FASTQ files] \
#[# parts to split into] [barcodes TSV file] [# to pass to --idxread] [# of mismatches to allow]
#Note: # of mismatches to allow will default to 0 if not provided.

#Specify the path to the ParsingPipeline:
PIPELINEDIR="[add parsing pipeline dir]/ParsingPipeline-master"

NUM_THREADS=8 #ALWAYS MATCH THIS TO THE VALUE OF --cpus-per-task

NUM_READFILES=4 #ADJUST THIS TO MATCH HOW MANY OF THE R# VARIABLES ARE SET

READFILE_PREFIX="[add read prefix]"
#eg READFILE_PREFIX="QuijaMau_CKDL200159071-1B_HC5N7CCX2_L2"

#Note: You may comment out any of these variables that you don't need,
# although you do need at least two: a read file, and an index read file
R1="${READFILE_PREFIX}_1.fq.gz"
R2="${READFILE_PREFIX}_1_I1.fastq.gz"
R3="${READFILE_PREFIX}_1_I2.fastq.gz" #USE THIS ONLY IF YOU HAVE DUAL-INDEXED LIBRARIES
R4="${READFILE_PREFIX}_2.fq.gz" #USE THIS ONLY IF YOU HAVE PAIRED-END LIBRARIES

I7INDICES="i5_barcodes.tsv" #Your customized version of i5_barcodes.tsv

PARSEREAD=3 #USE 2 IF YOU ARE PARSING i7, USE 3 IF YOU ARE PARSING i5
#Note that 2 and 3 only correspond to i7 and i5 if you place the i7 and i5
# read files as being the R2 and R3 variables.

NUM_MISMATCHES=1 #MAY SET TO 1, CHECK YOUR INDEX READ HISTOGRAM TO BE SURE 2 IS SAFE

srun ${PIPELINEDIR}/divideConquerParser.sh ${NUM_READFILES} "${R1} ${R2} ${R3} ${R4}" ${NUM_THREADS} ${I7INDICES} ${PARSEREAD} ${NUM_MISMATCHES}
popd