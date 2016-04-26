#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: macs
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

macs_link = "https://github.com/downloads/taoliu/MACS/MACS-1.4.2-1.tar.gz"
macs_tar = "#{node.dir.archive}/#{File.basename( macs_link )}"
macs_dir = "#{node.dir.software}/MACS-1.4.2"

directory node.dir.archive
directory node.dir.software

remote_file macs_tar do
  action :create_if_missing
  source macs_link
  retries 1
end

bash "extract_macs" do
  code "tar xf #{macs_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( macs_dir )}"
end

bash "build_macs" do
  code "python setup.py build"
  cwd macs_dir
  not_if "#{Dir.exists?( "#{macs_dir}/build" )}"
end

bash "install_macs" do
  code "python setup.py install"
  cwd macs_dir
  not_if "#{File.exists?( "/usr/local/bin/macs14" )}"
end
