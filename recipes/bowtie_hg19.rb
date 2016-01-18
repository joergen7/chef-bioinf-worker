#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bowtie_hg19
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

idx_url = "ftp://ftp.ccb.jhu.edu/pub/data/bowtie_indexes/hg19.ebwt.zip"
idx_dir = "#{node.dir.data}/bowtie_idx"

directory node.dir.data
directory idx_dir

remote_file "#{idx_dir}/#{File.basename( idx_url )}" do
  action :create_if_missing
  source idx_url
  retries 1
end

