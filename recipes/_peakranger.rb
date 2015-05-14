#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _peakranger
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin

peakranger_link = "http://downloads.sourceforge.net/project/ranger/PeakRanger-1.14-Linux-x86_64.zip"
peakranger_zip  = "#{archive}/#{File.basename( peakranger_link )}"
peakranger_dir  = "#{software}/PeakRanger-1.14-Linux-x86_64"

remote_file peakranger_zip do
    action :create_if_missing
    source peakranger_link
end

bash "extract_peakranger" do
    code "unzip -o #{peakranger_zip} -d #{peakranger_dir}"
    not_if "#{Dir.exists?( peakranger_dir )}"
end

link "#{bin}/ranger" do
    to "#{peakranger_dir}/ranger"
end
