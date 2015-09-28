#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bwa
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# package "bwa"

bwa_link = "http://downloads.sourceforge.net/project/bio-bwa/bwakit/bwakit-0.7.12_x64-linux.tar.bz2"
bwa_tar  = "#{node.dir.archive}/#{File.basename( bwa_link )}"
bwa_dir  = "#{node.dir.software}/bwa.kit"

directory node.dir.archive
directory node.dir.software

remote_file bwa_tar do
  action :create_if_missing
  source bwa_link
  retries 1
end

bash "extract_bwa" do
  code "tar xf #{bwa_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( bwa_dir )}"
end

link "#{node.dir.bin}/bwa" do
  to "#{bwa_dir}/bwa"
end
