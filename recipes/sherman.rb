#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: sherman
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.



sherman_link = "http://www.bioinformatics.babraham.ac.uk/projects/sherman/Sherman_v0.1.7.zip"
sherman_zip  = "#{node.dir.archive}/#{File.basename( sherman_link )}"
sherman_dir  = "#{node.dir.software}/Sherman_v0.1.7"


package "unzip"

directory node.dir.software
directory node.dir.archive
directory sherman_dir

remote_file sherman_zip do
    action :create_if_missing
    source sherman_link
    retries 1
end

bash "extract_sherman" do
    code "unzip -o #{sherman_zip} -d #{sherman_dir}"
    not_if "#{File.exists?( "#{sherman_dir}/Sherman" )}"
end

link "#{node.dir.bin}/Sherman" do
  to "#{sherman_dir}/Sherman"
end


