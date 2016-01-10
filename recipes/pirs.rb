#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: pirs
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

pirs_link = "https://pirs.googlecode.com/files/pIRS_110.tgz"
pirs_tar = "#{node.dir.archive}/#{File.basename( pirs_link )}"
pirs_dir = "#{node.dir.software}/pIRS_110"
pirs_bin = "#{node.dir.bin}/pirs"

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

file pirs_bin do
  content <<-SCRIPT
#!/usr/bin/env bash
#{pirs_dir}/pirs $@ \
-s #{pirs_dir}/Profiles/Base-Calling_Profiles/humNew.PE100.matrix.gz \
-b #{pirs_dir}/Profiles/InDel_Profiles/phixv2.InDel.matrix
  SCRIPT
  mode '0755'
end
