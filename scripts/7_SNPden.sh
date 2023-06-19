#!/bin/bash

## SNPdensity
VCFdir=/mnt/tank/#inputdir
OUTdir=/mnt/tank/#outputdir

for file in ${VCFdir}/*HD_PASS_DP5.vcf.gz
do
	echo $file
	vcftools --gzvcf $file --SNPdensity 1000 --out ${OUTdir}/${file}.densityPerKb
done