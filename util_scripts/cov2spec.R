#!/usr/bin/env Rscript

library(parallel)
library(rtracklayer)

args = commandArgs(trailingOnly=TRUE)
file.id <- args[1]
repeat.length <- readRDS(paste0("../",args[2]))

cov <- readRDS(file.id)

sd <- mclapply(cov, function(chrCov) {
  stepsize <- 100
  windowsize <- 1024
  freqs <- 0.5/windowsize*1:1024 # frequencies at which densities are reported
  repeatLengths <- 1/freqs
  selectFreq <- which.min(abs(repeatLengths-repeat.length))
  mw.views <- Views(chrCov, start=seq(1, to=(length(chrCov)-windowsize), by=stepsize ), width=windowsize)
  sds <- viewApply(mw.views, function(x){
    spec.pgram(as.vector(x), log="n", pad=1, spans=c(3,3), plot=F)$spec[selectFreq]
  })
  append(Rle(0,((windowsize/2)-1)), Rle(round(sds), rep(stepsize,length(mw.views))))
})

rl <- as(sd, "SimpleRleList")
file.id <- strsplit(file.id,"\\.")[[1]][1]
saveRDS(rl, file=paste0(file.id,"_spec_",repeat.length,".rds"))
export.bedGraph(rl, paste0(file.id,"_spec_",repeat.length,".wig"))


