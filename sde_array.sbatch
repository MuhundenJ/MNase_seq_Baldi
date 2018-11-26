#! /bin/bash
#
# sde_array.sbatch
#
#SBATCH -n 8        					# cores
#SBATCH -N 1         					# one node ?required
#SBATCH -t 0-80:00    					# Running time 
#SBATCH -o sde_array_%A_%a.out	# Standard output
#SBATCH -e sde_array_%A_%a.err    # Standard error

module load R/3.5.1

LINE_NO=$(echo ${SLURM_ARRAY_TASK_ID}+1 | bc)

## get parameters from table
SRUN=$(awk -F '\t' -v line=${LINE_NO} -v field=5 'NR==line{print $field}' SraRunTable.txt)

cd ${SRUN}_out

Rscript --vanilla ../util_scripts/cov2spec.R ${SRUN}_dyadCov.rds spectralRepeatLength.rds

cp ../sde_array_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.out .
cp ../sde_array_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.err .
