#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: peakranger
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.



directory node.dir.software
directory node.dir.archive

package "unzip"










peakranger114_link = "http://downloads.sourceforge.net/project/ranger/PeakRanger-1.14-Linux-x86_64.zip"
peakranger114_zip  = "#{node.dir.archive}/#{File.basename( peakranger114_link )}"
peakranger114_dir  = "#{node.dir.software}/PeakRanger-1.14"

remote_file peakranger114_zip do
  action :create_if_missing
  source peakranger114_link
  retries 1
end

bash "extract_peakranger_1.14" do
  code "unzip -o #{peakranger114_zip} -d #{peakranger114_dir}"
  not_if "#{Dir.exists?( peakranger114_dir )}"
end

link "#{node.dir.bin}/ranger" do
  to "#{peakranger114_dir}/ranger"
end





peakranger118_link = "http://downloads.sourceforge.net/project/ranger/PeakRanger-1.18-Linux-x86_64.zip"
peakranger118_zip  = "#{node.dir.archive}/#{File.basename( peakranger118_link )}"
peakranger118_dir  = "#{node.dir.software}/PeakRanger-1.18"

remote_file peakranger118_zip do
  action :create_if_missing
  source peakranger118_link
  retries 1
end

bash "extract_peakranger_1.18" do
  code "unzip -o #{peakranger118_zip} -d #{peakranger118_dir}"
  not_if "#{Dir.exists?( peakranger118_dir )}"
end

link "#{node.dir.bin}/peakranger" do
  to "#{peakranger118_dir}/bin/peakranger"
end
