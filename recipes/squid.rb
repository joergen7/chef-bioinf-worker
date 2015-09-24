#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: squid
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

squid_link = "ftp://selab.janelia.org/pub/software/squid/squid-1.9g.tar.gz"
squid_tar  = "#{node.dir.archive}/#{File.basename( squid_link )}"



directory node.dir.software
directory node.dir.archive

package "gcc"

remote_file squid_tar do
  action :create_if_missing
  source squid_link
  retries 1
end

bash "extract_squid" do
  code "tar xf #{squid_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( node.dir.squid )}"
end

bash "configure_squid" do
  code "./configure"
  cwd node.default.dir.squid
  not_if "#{File.exists?( "#{node.dir.squid}/Makefile" )}"
end

bash "compile_squid" do
  code "make"
  cwd node.default.dir.squid
  not_if "#{File.exists?( "#{node.dir.squid}/afetch" )}"
end


