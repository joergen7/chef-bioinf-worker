# coding: utf-8
#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: annodb_hg38
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

annodb_hg38_dir = "#{node.dir.data}/annodb_hg38"
annodb_hg38_idlist = ["refGene.txt", "refGeneMrna.fa", "refGeneVersion.txt"]

directory node.dir.data
directory annodb_hg38_dir

annodb_hg38_idlist.each { |id|

  url = "http://www.openbioinformatics.org/annovar/download/hg38_#{id}"
  file = "#{annodb_hg38_dir}/#{File.basename( url )}"
  file_gz = "#{file}.gz"
  url = "#{url}.gz"
  
  remote_file file_gz do
    action :create_if_missing
    source url
    retries 1
    not_if "#{File.exists?( file_gz ) || File.exists?( file )}"
  end
  
  bash "extract_#{file_gz}" do
    code "gunzip #{file_gz}"
    cwd annodb_hg38_dir
    not_if "#{File.exists?( file )}"
  end
}
