#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: kgenomes_vcf_11
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

vcf_set = ["chr1.phase1_release_v3",
           "chr2.phase1_release_v3",
           "chr3.phase1_release_v3",
           "chr4.phase1_release_v3",
           "chr5.phase1_release_v3",
           "chr6.phase1_release_v3",
           "chr7.phase1_release_v3",
           "chr8.phase1_release_v3",
           "chr9.phase1_release_v3",
           "chr10.phase1_release_v3",
           "chr11.phase1_release_v3",
           "chr12.phase1_release_v3",
           "chr13.phase1_release_v3",
           "chr14.phase1_release_v3",
           "chr15.phase1_release_v3",
           "chr16.phase1_release_v3",
           "chr17.phase1_release_v3",
           "chr18.phase1_release_v3",
           "chr19.phase1_release_v3",
           "chr20.phase1_release_v3",
           "chr21.phase1_release_v3",
           "chr22.phase1_release_v3",
           "chrX.phase1_release_v3"]


vcf_dir = "#{node.dir.data}/kgenomes_vcf_11"

directory node.dir.data
directory vcf_dir

vcf_set.each { |vcf|

  url = "ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20110521/ALL.#{vcf}.20101123.snps_indels_svs.genotypes.vcf.gz"
  
  remote_file "#{vcf_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
}
