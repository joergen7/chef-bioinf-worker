#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: sratools
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

sratools_vsn = "2.6.2"
sratools_link = "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/#{sratools_vsn}/sratoolkit.#{sratools_vsn}-ubuntu64.tar.gz"
sratools_tar  = "#{node.dir.archive}/#{File.basename( sratools_link )}"
sratools_dir  = "#{node.dir.software}/sratoolkit.#{sratools_vsn}-ubuntu64"


directory node.dir.software
directory node.dir.archive

remote_file sratools_tar do
  source sratools_link
  action :create_if_missing
  retries 1
end

bash "extract_sratools" do
  code "tar xf #{sratools_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( sratools_dir )}"
end

link "#{node.dir.bin}/fastq-dump" do
  to "#{sratools_dir}/bin/fastq-dump"
end
