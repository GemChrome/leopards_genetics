#!/bin/bash
#SBATCH --job-name=calling
#SBATCH --cpus-per-task=4
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-19%3
#SBATCH -o calling_%a_out.txt
#SBATCH -e calling_%a_err.txt 

## files
TAG=#sampleID
chr=$SLURM_ARRAY_TASK_ID
gatkdir=/mnt/tank/#gatkpath/gatk-4.4.0.0
datadir=/mnt/tank/#inputpath

## command
${gatkdir}/gatk HaplotypeCaller --java-options "-Xmx36g" \ 
	-I ${datadir}/${TAG}_dedup.bam -O ${TAG}_scaffold${chr}.vcf.gz \
	-R /mnt/tank/#refpath -L HiC_scaffold_${chr} \
	--native-pair-hmm-threads 4 
