#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: peakranger
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

peakranger_link = "http://downloads.sourceforge.net/project/ranger/PeakRanger-1.14-Linux-x86_64.zip"
peakranger_zip  = "#{node.dir.archive}/#{File.basename( peakranger_link )}"
peakranger_dir  = "#{node.dir.software}/PeakRanger-1.14-Linux-x86_64"




directory node.dir.software
directory node.dir.archive

package "unzip"

remote_file peakranger_zip do
  action :create_if_missing
  source peakranger_link
  retries 1
end

bash "extract_peakranger" do
  code "unzip -o #{peakranger_zip} -d #{peakranger_dir}"
  not_if "#{Dir.exists?( peakranger_dir )}"
end

link "#{node.dir.bin}/ranger" do
  to "#{peakranger_dir}/ranger"
end
