# coding: utf-8
#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: picard_tools
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# this Picard versin requires Java 8
# picard_vsn = "2.0.1"

picard_vsn = "2.5.0"
picard_link = "https://github.com/broadinstitute/picard/releases/download/#{picard_vsn}/picard-tools-#{picard_vsn}.zip"
picard_zip = "#{node.dir.archive}/#{File.basename( picard_link )}"
picard_dir = "#{node.dir.software}/picard-tools-#{picard_vsn}"

include_recipe "chef-bioinf-worker::java"

package "unzip"

directory node.dir.archive
directory node.dir.software

remote_file picard_zip do
  action :create_if_missing
  source picard_link
  retries 1
end

bash "extract_picard_tools" do
  code "unzip -o #{picard_zip} -d #{node.dir.software}"
  not_if "#{Dir.exists?( picard_dir )}"
end

file "#{node.dir.bin}/picard" do
  content <<-CONTENT
#!/usr/bin/env bash
java -jar #{picard_dir}/picard.jar $@  
  CONTENT
  mode '0755'
end

