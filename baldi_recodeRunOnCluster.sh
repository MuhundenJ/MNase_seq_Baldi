module load R/3.5.1

git clone https://github.com/bmc-CompBio/Baldi_recode.git

cd Baldi_recode

./00_prep.sh
./01_prefetchSRA.sh
./02_runAlign_SLURM.sh

####################################################
Rscript -e 'library(knitr); purl("03_PNA_SDE.Rmd")'
CMD_FOR_SUB=$(cat <<EOF
	module load R/3.5.1
	Rscript 03_PNA_SDE.R
EOF
)
sbatch --mem 40000 --wrap="$CMD_FOR_SUB"
rm 03_PNA_SDE.R
####################################################

./04_runSDE_SLURM.sh

####################################################
Rscript -e 'library(knitr); purl("05_diffPhasing.Rmd")'
CMD_FOR_SUB=$(cat <<EOF
	module load R/3.5.1
	Rscript 05_diffPhasing.R
EOF
)
sbatch --mem 40000 --wrap="$CMD_FOR_SUB"
rm 05_diffPhasing.R
####################################################

sbatch 06_de_novo_motif.sh

####################################################
Rscript -e 'library(knitr); purl("07_analyzeHits.Rmd")'
CMD_FOR_SUB=$(cat <<EOF
	module load R/3.5.1
	Rscript 07_analyzeHits.R
EOF
)
sbatch --mem 40000 --wrap="$CMD_FOR_SUB"
rm 07_analyzeHits.R
####################################################

