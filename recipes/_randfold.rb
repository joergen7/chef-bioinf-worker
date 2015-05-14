#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _randfold
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_squid"

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


randfold_link = "http://bioinformatics.psb.ugent.be/supplementary_data/erbon/nov2003/downloads/randfold-2.0.tar.gz"
randfold_tar  = "#{archive}/#{File.basename( randfold_link )}"
randfold_dir  = "#{software}/randfold-2.0"

remote_file randfold_tar do
    action :create_if_missing
    source randfold_link
end

bash "extract_randfold" do
    code "tar xf #{randfold_tar} -C #{software}"
    not_if "#{Dir.exists?( randfold_dir )}"
end

bash "compile_randfold" do
    code "make INCLUDE=\"-I. -I#{software}/squid-1.9g -L#{software}/squid-1.9g/\""
    cwd randfold_dir
    not_if "#{File.exists?( "#{randfold_dir}/randfold" )}"
end

link "#{bin}/randfold" do
  to "#{randfold_dir}/randfold"
end

