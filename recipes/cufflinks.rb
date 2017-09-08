#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: cufflinks
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

cufflinks_vsn  = "2.2.1"
cufflinks_link = "http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-#{cufflinks_vsn}.Linux_x86_64.tar.gz"
cufflinks_tar  = "#{node["dir"]["archive"]}/#{File.basename( cufflinks_link )}"
cufflinks_dir  = "#{node["dir"]["software"]}/cufflinks-#{cufflinks_vsn}.Linux_x86_64"

directory node["dir"]["software"]
directory node["dir"]["archive"]

remote_file cufflinks_tar do
  action :create_if_missing
  source cufflinks_link
  retries 1
end

bash "extract_cufflinks" do
    code "tar xf #{cufflinks_tar} -C #{node["dir"]["software"]}"
    not_if "#{Dir.exists?( cufflinks_dir )}"
end

link "#{node["dir"]["bin"]}/cufflinks" do
  to "#{cufflinks_dir}/cufflinks"
end

link "#{node["dir"]["bin"]}/cuffmerge" do
  to "#{cufflinks_dir}/cuffmerge"
end

link "#{node["dir"]["bin"]}/cuffdiff" do
  to "#{cufflinks_dir}/cuffdiff"
end

link "#{node["dir"]["bin"]}/gtf_to_sam" do
  to "#{cufflinks_dir}/gtf_to_sam"
end

link "#{node["dir"]["bin"]}/cuffcompare" do
  to "#{cufflinks_dir}/cuffcompare"
end

