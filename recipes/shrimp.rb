#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: shrimp
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

shrimp_link = "http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_2_2_3.lx26.x86_64.tar.gz"
shrimp_tar  = "#{node.dir.archive}/#{File.basename( shrimp_link )}"
shrimp_dir  = "#{node.dir.software}/SHRiMP_2_2_3"


directory node.dir.software
directory node.dir.archive

remote_file shrimp_tar do
  action :create_if_missing
  source shrimp_link
  retries 1
end

bash "extract_shrimp" do
  code "tar xf #{shrimp_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( shrimp_dir )}"
end

link "#{node.dir.bin}/gmapper-cs" do
  to "#{shrimp_dir}/bin/gmapper-cs"
end
