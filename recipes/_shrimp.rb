#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _shrimp
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


shrimp_link = "http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_2_2_3.lx26.x86_64.tar.gz"
shrimp_tar  = "#{archive}/#{File.basename( shrimp_link )}"
shrimp_dir  = "#{software}/SHRiMP_2_2_3"

remote_file shrimp_tar do
    action :create_if_missing
    source shrimp_link
end

bash "extract_shrimp" do
    code "tar xf #{shrimp_tar} -C #{software}"
    not_if "#{Dir.exists?( shrimp_dir )}"
end

link "#{bin}/gmapper-cs" do
  to "#{shrimp_dir}/bin/gmapper-cs"
end
