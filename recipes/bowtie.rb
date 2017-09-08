#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bowtie
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# package "bowtie"


bowtie_vsn  = "1.2.1.1"
bowtie_link = "http://downloads.sourceforge.net/project/bowtie-bio/bowtie/#{bowtie_vsn}/bowtie-#{bowtie_vsn}-linux-x86_64.zip"
bowtie_zip  = "#{node["dir"]["archive"]}/#{File.basename( bowtie_link )}"
bowtie_dir  = "#{node["dir"]["software"]}/bowtie-#{bowtie_vsn}"


directory node["dir"]["archive"]
directory node["dir"]["software"]

package "unzip"

remote_file bowtie_zip do
  action :create_if_missing
  source bowtie_link
  retries 1
end

bash "extract_bowtie" do
  code "unzip -o #{bowtie_zip} -d #{node["dir"]["software"]}"
  not_if "#{Dir.exists?( bowtie_dir )}"
end

link "#{node["dir"]["bin"]}/bowtie" do
  to "#{bowtie_dir}/bowtie"
end

link "#{node["dir"]["bin"]}/bowtie-build" do
  to "#{bowtie_dir}/bowtie-build"
end

link "#{node["dir"]["bin"]}/bowtie-inspect" do
  to "#{bowtie_dir}/bowtie-inspect"
end
