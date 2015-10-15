#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: msgf
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

msgf_link = "http://proteomics.ucsd.edu/Software/MSGFPlus/MSGFPlus.zip"
msgf_zip  = "#{node.dir.archive}/#{File.basename( msgf_link )}"
msgf_dir  = "#{node.dir.software}/msgf"
msgf_jar  = "#{msgf_dir}/MSGFPlus.jar"


include_recipe "chef-bioinf-worker::java"

directory node.dir.software
directory node.dir.archive

package "unzip"

remote_file msgf_zip do
  action :create_if_missing
  source msgf_link
  retries 1
end

bash "extract_msgf" do
  code "unzip -o #{msgf_zip} -d #{msgf_dir}"
  not_if "#{File.exists?( msgf_jar )}"
end

file "#{node.dir.bin}/msgf" do
  content <<-SCRIPT
#!/usr/bin/env bash
java -Xmx3500M -jar #{msgf_jar} $@
  SCRIPT
  mode "0755"
end

file "#{node.dir.bin}/buildsa" do
  content <<-SCRIPT
#!/usr/bin/env bash
java -Xmx3500M -cp #{msgf_jar} edu.ucsd.msjava.msdbsearch.BuildSA $@
  SCRIPT
  mode "0755"
end

link "#{node.dir.etc}/MSGFPlus.jar" do
  to msgf_jar
end
