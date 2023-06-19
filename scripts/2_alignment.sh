#!/bin/bash
#SBATCH --job-name=bwa
#SBATCH --cpus-per-task=12
#SBATCH --mem=26G
#SBATCH -o bwa_out.txt
#SBATCH -e bwa_err.txt
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1

TAG=#filename
SAMPLE=#samplename
threads=$SLURM_CPUS_PER_TASK
DATApath=/mnt/tank/#fullpath

## bwa 
bwa mem -t $threads -R '@RG\tID:PP116\tPL:ILLUMINA\tPU:PP116\tLB:PP116\tSM:PP116' \
	/mnt/tank/#refpath \
	${DATApath}/${TAG}_1_fastp.fastq.gz ${DATApath}/${TAG}_2_fastp.fastq.gz -M | samtools sort \
	-@$threads -o ${SAMPLE}.bam -   
