#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bedtools
#
# Copyright (c) 2015 The Authors, All Rights Reserved.


bedtools_vsn  = "2.26.0"
bedtools_link = "https://github.com/arq5x/bedtools2/releases/download/v#{bedtools_vsn}/bedtools-#{bedtools_vsn}.tar.gz"
bedtools_tar  = "#{node["dir"]["archive"]}/#{File.basename( bedtools_link )}"
bedtools_dir  = "#{node["dir"]["software"]}/bedtools2"



package "g++"

directory node["dir"]["software"]
directory node["dir"]["archive"]

remote_file bedtools_tar do
  action :create_if_missing
  source bedtools_link
  retries 1
end

bash "extract_bedtools" do
  code "tar xf #{bedtools_tar} -C #{node["dir"]["software"]}"
  not_if "#{Dir.exists?( bedtools_dir )}"
end

bash "compile_bedtools" do
  code "make"
  cwd bedtools_dir
  not_if "#{File.exists?( "#{bedtools_dir}/bin/bedtools" )}"
end

link "#{node["dir"]["bin"]}/sortBed" do
  to "#{bedtools_dir}/bin/sortBed"
end

link "#{node["dir"]["bin"]}/bedtools" do
  to "#{bedtools_dir}/bin/bedtools"
end
