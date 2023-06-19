#!/bin/bash
#SBATCH --job-name=trimming
#SBATCH --cpus-per-task=6
#SBATCH --mem=20G
#SBATCH -o ./out/007.trimming.out
#SBATCH -e ./err/007.trimming.err

## path
TAG=#sampleID
DATApath=/mnt/tank/#datapath
TRIMpath=/mnt/tank/#outputpath
DATA1=${DATApath}/ERR${TAG}_1.fastq.gz #input1
DATA2=${DATApath}/ERR${TAG}_2.fastq.gz #input2
TRIM1=${TRIMpath}/ERR${TAG}_1_fastp.fastq.gz #output1
TRIM2=${TRIMpath}/ERR${TAG}_2_fastp.fastq.gz #output2


## trimming
fastp --in1 $DATA1 --out1 $TRIM1 --in2 $DATA2 --out2 $TRIM2 --json ${TRIMpath}/${TAG}.json --html ${TRIMpath}/${TAG}.html --trim_front1 5 --trim_front2 5 --detect_adapter_for_pe -l 35 -q 20 --overrepresentation_analysis --thread 5 --report_title $TAG

