#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: trimgalore
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


trimgalore_link = "http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/trim_galore_v0.4.0.zip"
trimgalore_zip  = "#{node.dir.archive}/#{File.basename( trimgalore_link )}"
trimgalore_dir  = "#{node.dir.software}/trim_galore_zip"


include_recipe "chef-bioinf-worker::cutadapt"

package "unzip"

directory node.dir.software
directory node.dir.archive

remote_file trimgalore_zip do
  action :create_if_missing
  source trimgalore_link
  retries 1
end

bash "extract_trimgalore" do
  code "unzip -o #{trimgalore_zip} -d #{node.dir.software}"
  not_if "#{Dir.exists?( "#{trimgalore_dir}" )}"
end

link "#{node.dir.bin}/trim_galore" do
  to "#{trimgalore_dir}/trim_galore"
end


