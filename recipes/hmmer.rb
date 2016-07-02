#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: hmmer
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

hmmer_link = "http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz"
hmmer_tar  = "#{node.dir.archive}/#{File.basename( hmmer_link )}"
hmmer_dir  = "#{node.dir.software}/hmmer-3.1b2-linux-intel-x86_64"

directory node.dir.software
directory node.dir.archive

remote_file hmmer_tar do
  action :create_if_missing
  source hmmer_link
  retries 1
end

bash "extract_hmmer" do
  code "tar xf #{hmmer_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( hmmer_dir )}"
end

link "#{node.dir.bin}/hmmbuild" do
  to "#{hmmer_dir}/binaries/hmmbuild"
end

link "#{node.dir.bin}/hmmsearch" do
  to "#{hmmer_dir}/binaries/hmmsearch"
end

link "#{node.dir.bin}/esl-reformat" do
  to "#{hmmer_dir}/binaries/esl-reformat"
end

