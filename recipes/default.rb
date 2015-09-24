#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::annovar"
include_recipe "chef-bioinf-worker::bedtools"
include_recipe "chef-bioinf-worker::bismark"
include_recipe "chef-bioinf-worker::blast"
include_recipe "chef-bioinf-worker::bowtie"
include_recipe "chef-bioinf-worker::bowtie2"
include_recipe "chef-bioinf-worker::bsmooth"
include_recipe "chef-bioinf-worker::bsseq"
include_recipe "chef-bioinf-worker::bwa"
include_recipe "chef-bioinf-worker::cufflinks"
include_recipe "chef-bioinf-worker::cummerbund"
include_recipe "chef-bioinf-worker::cutadapt"
include_recipe "chef-bioinf-worker::deseq"
include_recipe "chef-bioinf-worker::fastqc"
include_recipe "chef-bioinf-worker::hg38"
include_recipe "chef-bioinf-worker::hmmer"
include_recipe "chef-bioinf-worker::muscle"
include_recipe "chef-bioinf-worker::openms"
include_recipe "chef-bioinf-worker::peakranger"
include_recipe "chef-bioinf-worker::qiime"
include_recipe "chef-bioinf-worker::randfold"
include_recipe "chef-bioinf-worker::samtools"
include_recipe "chef-bioinf-worker::sherman"
include_recipe "chef-bioinf-worker::shrimp"
include_recipe "chef-bioinf-worker::sratools"
include_recipe "chef-bioinf-worker::star"
include_recipe "chef-bioinf-worker::tophat"
include_recipe "chef-bioinf-worker::trimgalore"
include_recipe "chef-bioinf-worker::trimmomatic"
include_recipe "chef-bioinf-worker::varscan"
include_recipe "chef-bioinf-worker::viennarna"

