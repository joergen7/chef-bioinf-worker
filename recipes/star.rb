#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: star
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

star_link = "https://github.com/alexdobin/STAR/archive/STAR_2.4.1d.tar.gz"
star_tar  = "#{node.default.dir.archive}/#{File.basename( star_link )}"
star_dir  = "#{node.default.dir.software}/STAR-STAR_2.4.1d"


directory node.default.dir.software
directory node.default.dir.archive

remote_file star_tar do
    action :create_if_missing
    source star_link
end

bash "extract_star" do
    code "tar xf #{star_tar} -C #{node.default.dir.software}"
    not_if "#{Dir.exists?( star_dir )}"
end


link "#{node.default.dir.bin}/STAR" do
  to "#{star_dir}/bin/Linux_x86_64/STAR"
end

