#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: fastqc
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

fastqc_link = "http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.4.zip"
fastqc_zip = "#{node.dir.archive}/#{File.basename( fastqc_link )}"
fastqc_dir = "#{node.dir.software}/FastQC"




include_recipe "chef-bioinf-worker::java"

directory node.dir.software
directory node.dir.archive

package "unzip"

remote_file fastqc_zip do
  action :create_if_missing
  source fastqc_link
  retries 1
end

bash "extract_fastqc" do
  code "unzip -o #{fastqc_zip} -d #{node.dir.software}"
  not_if "#{Dir.exists?( fastqc_dir )}"
end

link "#{node.dir.bin}/fastqc" do
  to "#{fastqc_dir}/fastqc"
  mode "775"
end
