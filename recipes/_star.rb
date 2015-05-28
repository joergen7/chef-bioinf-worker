#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _star
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


star_link = "https://github.com/alexdobin/STAR/archive/STAR_2.4.1d.tar.gz"
star_tar  = "#{archive}/#{File.basename( star_link )}"
star_dir  = "#{software}/STAR-STAR_2.4.1d"

remote_file star_tar do
    action :create_if_missing
    source star_link
end

bash "extract_star" do
    code "tar xf #{star_tar} -C #{software}"
    not_if "#{Dir.exists?( star_dir )}"
end


link "#{bin}/STAR" do
  to "#{star_dir}/bin/Linux_x86_64/STAR"
end

