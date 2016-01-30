#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: kgenomes_vcf
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

vcf_set = ["chr1.phase3_shapeit2_mvncall_integrated_v5a",
           "chr2.phase3_shapeit2_mvncall_integrated_v5a",
           "chr3.phase3_shapeit2_mvncall_integrated_v5a",
           "chr4.phase3_shapeit2_mvncall_integrated_v5a",
           "chr5.phase3_shapeit2_mvncall_integrated_v5a",
           "chr6.phase3_shapeit2_mvncall_integrated_v5a",
           "chr7.phase3_shapeit2_mvncall_integrated_v5a",
           "chr8.phase3_shapeit2_mvncall_integrated_v5a",
           "chr9.phase3_shapeit2_mvncall_integrated_v5a",
           "chr10.phase3_shapeit2_mvncall_integrated_v5a",
           "chr11.phase3_shapeit2_mvncall_integrated_v5a",
           "chr12.phase3_shapeit2_mvncall_integrated_v5a",
           "chr13.phase3_shapeit2_mvncall_integrated_v5a",
           "chr14.phase3_shapeit2_mvncall_integrated_v5a",
           "chr15.phase3_shapeit2_mvncall_integrated_v5a",
           "chr16.phase3_shapeit2_mvncall_integrated_v5a",
           "chr17.phase3_shapeit2_mvncall_integrated_v5a",
           "chr18.phase3_shapeit2_mvncall_integrated_v5a",
           "chr19.phase3_shapeit2_mvncall_integrated_v5a",
           "chr20.phase3_shapeit2_mvncall_integrated_v5a",
           "chr21.phase3_shapeit2_mvncall_integrated_v5a",
           "chr22.phase3_shapeit2_mvncall_integrated_v5a",
           "chrX.phase3_shapeit2_mvncall_integrated_v1b",
           "chrY.phase3_integrated_v1b"
          ]


vcf_dir = "#{node.dir.data}/kgenomes_vcf_13"

directory node.dir.data
directory vcf_dir

vcf_set.each { |vcf|

  url = "ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/release/20130502/ALL.#{vcf}.20130502.genotypes.vcf.gz"
  
  remote_file "#{vcf_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
}
