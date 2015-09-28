#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: perm
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

perm_link = "https://perm.googlecode.com/files/PerM4_Linux64.gz"
perm_gz = "#{node.dir.archive}/#{File.basename( perm_link )}"
perm_dir  = "#{node.dir.software}/PerM4"
perm_bin  = "#{perm_dir}/Perm4_Linux64" 

directory node.dir.archive
directory node.dir.software
directory perm_dir

remote_file perm_gz do
  action :create_if_missing
  source perm_link
  retries 1
end

bash "extract_perm" do
  code "gzip -d -c -k #{perm_gz} > #{perm_bin}; chmod a+x #{perm_bin}"
  not_if "#{File.exists?( perm_bin )}"
end

link "#{node.dir.bin}/PerM4" do
  to perm_bin
end

