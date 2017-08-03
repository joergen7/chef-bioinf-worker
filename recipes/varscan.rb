#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: varscan
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

varscan_link = "http://downloads.sourceforge.net/project/varscan/VarScan.v2.3.9.jar"
varscan_jar  = "#{node["dir"]["jar"]}/#{File.basename( varscan_link )}"




include_recipe "chef-bioinf-worker::java"

directory node["dir"]["software"]
directory node["dir"]["jar"]

remote_file varscan_jar do
  source varscan_link
  action :create_if_missing
  retries 1
end

file "#{node["dir"]["bin"]}/varscan" do
  content <<-SCRIPT
#!/usr/bin/env bash
java -jar #{varscan_jar} $@
  SCRIPT
  mode "0755"
end
