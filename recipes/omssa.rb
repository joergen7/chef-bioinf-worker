#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: omssa
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

omssa_link = "ftp://ftp.ncbi.nih.gov/pub/lewisg/omssa/2.1.9/omssa-2.1.9.linux.tar.gz"
omssa_tar  = "#{node.dir.archive}/#{File.basename( omssa_link )}"
omssa_dir  = "#{node.dir.software}/omssa-2.1.9.linux"

directory node.dir.archive
directory node.dir.software

remote_file omssa_tar do
  action :create_if_missing
  source omssa_link
  retries 1
end

bash "extract_omssa" do
  code "tar xf #{omssa_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( omssa_dir )}"
end


link "#{node.dir.bin}/omssa2pepXML" do
  to "#{omssa_dir}/omssa2pepXML"
end

link "#{node.dir.bin}/omssacl" do
  to "#{omssa_dir}/omssacl"
end

link "#{node.dir.bin}/omssamerge" do
  to "#{omssa_dir}/omssamerge"
end

