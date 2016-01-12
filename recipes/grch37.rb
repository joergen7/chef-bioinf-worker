#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: grch37
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

grch37_dir = "#{node.dir.data}/grch37"
grch37_link = "ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/phase2_reference_assembly_sequence/hs37d5.fa.gz"

directory node.dir.data
directory grch37_dir

remote_file "#{grch37_dir}/#{File.basename( grch37_link )}" do
  action :create_if_missing
  source grch37_link
  retries 1
end

bash "extract_grch37" do
  code "gzip -d #{grch37_dir}/#{File.basename( grch37_link )}"
  not_if "#{File.exists?( "#{grch37_dir}/hs37d5.fa" )}"
  ignore_failure true
end
