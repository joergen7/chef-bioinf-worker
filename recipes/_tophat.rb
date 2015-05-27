#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _tophat
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_bowtie2"
include_recipe "chef-bioinf-worker::_samtools"

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


tophat_link = "http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz"
tophat_tar  = "#{archive}/#{File.basename( tophat_link )}"
tophat_dir  = "#{software}/tophat-2.0.13.Linux_x86_64"

remote_file tophat_tar do
    action :create_if_missing
    source tophat_link
end

bash "extract_tophat" do
    code "tar xf #{tophat_tar} -C #{software}"
    not_if "#{Dir.exists?( tophat_dir )}"
end

link "#{bin}/tophat" do
  to "#{tophat_dir}/tophat"
end
