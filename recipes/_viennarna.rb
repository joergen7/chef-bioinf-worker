#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _viennarna
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


viennarna_link = "http://www.tbi.univie.ac.at/RNA/download.php?id=viennarna-2.1.9"
viennarna_tar  = "#{archive}/ViennaRNA-2.1.9.tar.gz"
viennarna_dir  = "#{software}/ViennaRNA-2.1.9"

remote_file viennarna_tar do
    action :create_if_missing
    source viennarna_link
end

bash "extract_viennarna" do
    code "tar xf #{viennarna_tar} -C #{software}"
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

link "#{bin}/RNAfold" do
  to "#{viennarna_dir}/Progs/RNAfold"
end

