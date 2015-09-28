#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bfast
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

bfast_link = "http://downloads.sourceforge.net/project/bfast/bfast/0.7.0/bfast-0.7.0a.tar.gz"
bfast_zip  = "#{node.dir.archive}/#{File.basename( bfast_link )}"
bfast_dir  = "#{node.dir.software}/bfast-0.7.0a"

directory node.dir.archive
directory node.dir.software

package "gcc"
package "git"
package "libbz2-dev"

remote_file bfast_zip do
  action :create_if_missing
  source bfast_link
  retries 1
end

bash "extract_bfast" do
  code "tar xf #{bfast_zip} -C #{node.dir.software}"
  not_if "#{Dir.exists?( bfast_dir )}"
end

bash "configure_bfast" do
  code "./configure"
  cwd bfast_dir
  not_if "#{File.exists?( "#{bfast_dir}/Makefile" )}"
end

bash "build_bfast" do
  code "make"
  cwd bfast_dir
  not_if "#{File.exists?( "#{bfast_dir}/bfast/bfast" )}"
end

link "#{node.dir.bin}/bfast" do
  to "#{bfast_dir}/bfast/bfast"
end

