#! /bin/bash

#SBATCH -p slim16
#SBATCH -n 64

module load meme/5.0.2
module load ngs/Homer/4.10

# all MEME
meme seqs/downPNA.fasta -nmotifs 10 -dna -revcomp -mod zoops -oc motifs/meme_zoops -p 62
fimo --oc hits/meme_zoops_m1 --motif BGGMCMACRBKGCGTATRCGTAATR motifs/meme_zoops/meme.txt  /work/data/genomes/fly/Drosophila_melanogaster/Ensembl/BDGP6/Sequence/WholeGenomeFasta/genome.fa

# HOMER
findMotifsGenome.pl seqs/downPNA.bed dm6 motifs/homer -preparsedDir seqs
scanMotifGenomeWide.pl motifs/homer/homerResults/motif1.motif dm6 -bed > hits/homer.sites.dm6.bed

