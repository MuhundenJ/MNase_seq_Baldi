This pipeline demonstrates analysis of MNase-seq data for de novo identification and characterization of Phased Nucleosome Arrays originally developed by Baldi et al. and adapted for additional downstream analyses. 

Example downstream workflow (characterization of PNAs) is previewed here : https://htmlpreview.github.io/?https://github.com/MuhundenJ/MNase_seq_Baldi/blob/master/TRAX_EDA_v2.html


# Full re-code of Baldi et al 2018

<http://dx.doi.org/10.1016/j.molcel.2018.09.032>

Demonstration of de-novo motif search on selected genomic regions using both, MEME and Homer. This project provides all code for the definition of the regions starting from the raw data deposited at the SRA. In also includes the spectral analysis part. 

The data is mapped to dm6 (which is in contrast to the paper, in which we used dm3).

The unix part of the code was set to run on the cluster, the R part was run locally.

## 1)  preparation

`00_prep.sh` - creates some required directories in the project folder

`01_prefetchSRA.sh` - reads the samples of interest from SraRunTable.txt and fetches the data into the local cache 

## 2) alignment

`02_runAlign_SLURM` - aligns the samples using the sde_array.sbatch script.

## 3)  SDE

`03_PNA_SDE.Rmd` - preparation for SDE, i.e. filtering, subsampling and determination of the average NRL

`04_runSDE_SLURM.sh` - SDE run on cluster 

## 4) define regions of differential phasing

`05_diffPhasing.Rmd`

## 5) de-novo motif analysis on differential PNA

`06_de_novo_motif.sh`

## 6) comparative analysis of the motif hit regions (Homer vs. MEME)

`07_analyzeHits.Rmd`

