#!/bin/bash
#SBATCH --job-name=popgen
#SBATCH --cpus-per-task=12
#SBATCH --mem=26G
#SBATCH -o popgen_out.txt
#SBATCH -e popgen_err.txt
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1

## files
TAG=#filename
VCFdir=/mnt/tank/#inputpath
OUTdir=/mnt/tank/#outputpath

## ROHs
./plink --vcf ${VCFdir}/${TAG}.vcf.gz --out ${OUTdir}/${TAG}_plink.hom --homozyg \
	--allow-extra-chr --homozyg-window-snp 20 --homozyg-density 50 \
	--homozyg-kb 10 \ --cluster --matrix --mds-plot 10

## heterozygosity 
vcftools --gzvcf ${VCFdir}/${TAG}.vcf.gz --het --out ${OUTdir}/${filename}_het


