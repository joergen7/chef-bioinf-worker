#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: star
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

star_link = "https://github.com/alexdobin/STAR/archive/STAR_2.4.1d.tar.gz"
star_tar  = "#{node.dir.archive}/#{File.basename( star_link )}"
star_dir  = "#{node.dir.software}/STAR-STAR_2.4.1d"


directory node.dir.software
directory node.dir.archive

remote_file star_tar do
    action :create_if_missing
    source star_link
    retries 1
end

bash "extract_star" do
    code "tar xf #{star_tar} -C #{node.dir.software}"
    not_if "#{Dir.exists?( star_dir )}"
end


link "#{node.dir.bin}/STAR" do
  to "#{star_dir}/bin/Linux_x86_64/STAR"
end

