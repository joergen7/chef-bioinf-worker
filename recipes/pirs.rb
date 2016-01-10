#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: pirs
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

pirs_link = "https://pirs.googlecode.com/files/pIRS_110.tgz"
pirs_tar = "#{node.dir.archive}/#{File.basename( pirs_link )}"
pirs_dir = "#{node.dir.software}/pIRS_110"

directory node.dir.archive
directory node.dir.software


remote_file pirs_tar do
  action :create_if_missing
  source pirs_link
  retries 1
end

bash "extract_pirs" do
  code "tar xf #{pirs_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( pirs_dir )}"
end

link "#{node.dir.bin}/pirs" do
  to "#{pirs_dir}/pirs"
end
