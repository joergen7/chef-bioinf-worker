#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _bedtools
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


bedtools_link = "https://github.com/arq5x/bedtools2/releases/download/v2.22.1/bedtools-2.22.1.tar.gz"
bedtools_tar  = "#{archive}/#{File.basename( bedtools_link )}"
bedtools_dir  = "#{software}/bedtools2"

remote_file bedtools_tar do
    action :create_if_missing
    source bedtools_link
end

bash "extract_bedtools" do
    code "tar xf #{bedtools_tar} -C #{software}"
    not_if "#{Dir.exists?( bedtools_dir )}"
end

bash "compile_bedtools" do
    code "make"
    cwd bedtools_dir
    not_if "#{File.exists?( "#{bedtools_dir}/bin/bedtools" )}"
end

link "#{bin}/sortBed" do
  to "#{bedtools_dir}/bin/sortBed"
end

link "#{bin}/bedtools" do
  to "#{bedtools_dir}/bin/bedtools"
end
