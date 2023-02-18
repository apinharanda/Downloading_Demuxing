#!/bin/bash

# v2 AP 2 Feb 2022
#v3 AP Jun2022 change -q 0

#need to have base_genomics env active

#usage
#sbatch --account=palab -N 1 trim_galore.sh read1 read2 #for HPC
#bash trim_galore.sh read1 read2 #for headnode
 
# e.g.
# sbatch --account=palab trim_galore.sh S01_WT_Empty_Mock_1.fq.gz S01_WT_Empty_Mock_2.fq.gz #for HPC
# bash trim_galore.sh S01_WT_Empty_Mock_1.fq.gz S01_WT_Empty_Mock_2.fq.gz #for head node

# make a script to run all the reads in a dir and then run that (which is the simplest)
#change end of the reads accordingly
#ls -1 *_1.fastq.gz | awk '{print "sbatch --account=palab --time=05:00:00 trim_galore.sh " $1 " "$1"_"}' | sed 's/_1.fastq.gz_/_4.fastq.gz/g' | sed '1 i #!/bin/bash' > submit_trim_galore.sh
#bash submit_trim_galore.sh 

#--time=05:00:00 goes to the short queue, so it runs v fast
#if it is for SE reads remove --paired option & remove $read2
   
##### read in command line
read1=$1
read2=$2

trim_galore -q 0 --fastqc -e 0.1 --length 20 --paired --path_to_cutadapt cutadapt $read1 $read2