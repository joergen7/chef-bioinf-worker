#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bowtie2
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# package "bowtie2"

bowtie2_vsn  = "2.3.3"
bowtie2_link = "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/#{bowtie2_vsn}/bowtie2-#{bowtie2_vsn}-linux-x86_64.zip"
bowtie2_zip  = "#{node["dir"]["archive"]}/#{File.basename( bowtie2_link )}"
bowtie2_dir  = "#{node["dir"]["software"]}/bowtie2-#{bowtie2_vsn}"


directory node["dir"]["archive"]
directory node["dir"]["software"]

package "unzip"
package "libtbb-dev"

remote_file bowtie2_zip do
  action :create_if_missing
  source bowtie2_link
  retries 1
end

bash "extract_bowtie2" do
  code "unzip -o #{bowtie2_zip} -d #{node["dir"]["software"]}"
  creates bowtie2_dir
end

link "#{node["dir"]["bin"]}/bowtie2" do
  to "#{bowtie2_dir}/bowtie2"
end

link "#{node["dir"]["bin"]}/bowtie2-build" do
  to "#{bowtie2_dir}/bowtie2-build"
end
