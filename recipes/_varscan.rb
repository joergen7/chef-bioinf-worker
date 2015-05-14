#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _varscan
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

jar = node.default.dir.jar
bin = node.default.dir.bin

include_recipe "chef-bioinf-worker::_java"

varscan_link = "http://downloads.sourceforge.net/project/varscan/VarScan.v2.3.7.jar"
varscan_jar  = "#{jar}/#{File.basename( varscan_link )}"

remote_file varscan_jar do
    source varscan_link
    action :create_if_missing
end

file "#{bin}/varscan" do
    content <<-SCRIPT
#!/usr/bin/env bash
java -jar #{varscan_jar} $@
    SCRIPT
    mode "0755"
end
