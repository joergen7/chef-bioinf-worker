#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: viennarna
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

viennarna_link = "http://www.tbi.univie.ac.at/RNA/download.php?id=viennarna-2.1.9"
viennarna_tar  = "#{node.dir.archive}/ViennaRNA-2.1.9.tar.gz"
viennarna_dir  = "#{node.dir.software}/ViennaRNA-2.1.9"

package "g++"

directory node.dir.software
directory node.dir.archive

remote_file viennarna_tar do
  action :create_if_missing
  source viennarna_link
  retries 1
end

bash "extract_viennarna" do
  code "tar xf #{viennarna_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( viennarna_dir )}"
end

bash "configure_viennarna" do
  code "./configure"
  cwd viennarna_dir
  not_if "#{File.exists?( "#{viennarna_dir}/Makefile" )}"
end

bash "compile_viennarna" do
  code "make"
  cwd viennarna_dir
  not_if "#{File.exists?( "#{viennarna_dir}/Progs/RNAfold" )}"
end

link "#{node.dir.bin}/RNAfold" do
  to "#{viennarna_dir}/Progs/RNAfold"
end

