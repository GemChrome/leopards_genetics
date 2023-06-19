#!/bin/bash
#SBATCH --job-name=filtering
#SBATCH --cpus-per-task=12
#SBATCH --mem=26G
#SBATCH -o filters_out.txt
#SBATCH -e filters_err.txt
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1

## data
TAG=#sampleID
DATAdir=/mnt/tank/#inputpath/${TAG}
GATKdir=/mnt/tank/#gatkpath/gatk-4.4.0.0

## filtering
bcftools stats ${TAG}_calling.vcf.gz > ${TAG}_initial.stat
 
## select snps
${GATKdir}/gatk SelectVariants -V ${DATAdir}/${TAG}_calling.vcf.gz -select-type SNP \
	-O ${TAG}_snps.vcf.gz

## filters
${GATKdir}/gatk VariantFiltration -V ${TAG}_snps.vcf.gz -filter "QD < 2.0" --filter-name "QD2" -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "SOR > 3.0" --filter-name "SOR3" -filter "FS > 60.0" --filter-name "FS60" -filter "MQ < 40.0" --filter-name "MQ40" -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" -O ${TAG}_HF.vcf.gz

## PASS
bcftools view -f PASS -Oz ${TAG}_HF.vcf.gz -o ${TAG}_HF_PASS.vcf.gz 
bcftools stats ${TAG}_HF_PASS.vcf.gz > ${TAG}_HF_PASS.stat 

## filter DP
bcftools filter -Oz -i 'FORMAT/DP>=5' ${TAG}_HF_PASS.vcf.gz -o ${TAG}_HF_PASS_DP5.vcf.gz 
bcftools stats ${TAG}_HF_PASS_DP5.vcf.gz > ${TAG}_HF_PASS_DP5.stat