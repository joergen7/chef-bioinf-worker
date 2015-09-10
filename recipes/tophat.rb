#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _tophat
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

tophat_link = "http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz"
tophat_tar  = "#{node.default.dir.archive}/#{File.basename( tophat_link )}"
tophat_dir  = "#{node.default.dir.software}/tophat-2.0.13.Linux_x86_64"


include_recipe "chef-bioinf-worker::bowtie"
include_recipe "chef-bioinf-worker::bowtie2"
include_recipe "chef-bioinf-worker::samtools"

directory node.default.dir.software
directory node.default.dir.archive

remote_file tophat_tar do
    action :create_if_missing
    source tophat_link
end

bash "extract_tophat" do
    code "tar xf #{tophat_tar} -C #{node.default.dir.software}"
    not_if "#{Dir.exists?( tophat_dir )}"
end

link "#{node.default.dir.bin}/tophat" do
  to "#{tophat_dir}/tophat"
end
