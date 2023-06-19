#!/bin/bash
#SBATCH --job-name=pca
#SBATCH --cpus-per-task=12
#SBATCH --mem=26G
#SBATCH -o pca_out.txt
#SBATCH -e pca_err.txt
#SBATCH --time=12:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1

## files
TAG=#filename
VCFdir=/mnt/tank/#inputdir

## linkage pruning
./plink --vcf ${VCFdir}/${TAG}.vcf.gz --double-id --allow-extra-chr \
	--set-missing-var-ids @:# \
	--indep-pairwise 50 10 0.1 --out leo_prune

## pca
./plink --vcf ${VCFdir}/${TAG}.vcf.gz --double-id --allow-extra-chr \
		--set-missing-var-ids @:# \
		--extract leo_prune.prune.in \
		--make-bed --pca --out leo_pca