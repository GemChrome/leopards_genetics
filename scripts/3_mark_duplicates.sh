#!/bin/bash
#SBATCH --job-name=markdup
#SBATCH --cpus-per-task=12
#SBATCH --mem=26G
#SBATCH --array=1
#SBATCH -o markdup_out.txt
#SBATCH -e markdup_err.txt
#SBATCH --nodes=1

TAG=#sampleID
threads=$SLURM_CPUS_PER_TASK
datadir=/mnt/tank/#inputdir
picard=/mnt/tank/#picarddir

## mark duplicates
java -jar -Xmx8g ${picard}/picard.jar MarkDuplicates I=${datadir}/${TAG}.bam O=${TAG}_dedup.bam M=${TAG}_metrics.txt CREATE_INDEX=true

## collect metrics
java -jar ${picard}/picard.jar CollectWgsMetrics I=${TAG}_dedup.bam O=${TAG}_CollectWgsMetrics.txt R=/mnt/tank/#refpath

java -jar ${picard}/picard.jar CollectAlignmentSummaryMetrics R=/mnt/tank/#refpath I=${TAG}_dedup.bam O=${TAG}_AlignmentMetrics.txt