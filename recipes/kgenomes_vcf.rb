#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: kgenomes_vcf
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

vcf_set = ["chr1",
           "chr2",
           "chr3",
           "chr4",
           "chr5",
           "chr6",
           "chr7",
           "chr8",
           "chr9",
           "chr10",
           "chr11",
           "chr12",
           "chr13",
           "chr14",
           "chr15",
           "chr16",
           "chr17",
           "chr18",
           "chr19",
           "chr20",
           "chr21",
           "chr22",
           "chrX",
           "chrY",
           "wgs"
          ]


vcf_dir = "#{node.dir.data}/vcf_grch37"

directory node.dir.data
directory vcf_dir

vcf_set.each { |vcf|

  url = "ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/ALL.#{vcf}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz"
  
  remote_file "#{vcf_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
}
