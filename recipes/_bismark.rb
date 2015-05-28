#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _bismark
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_bowtie"
include_recipe "chef-bioinf-worker::_bowtie2"
include_recipe "chef-bioinf-worker::_samtools"

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin

bismark_link = "http://www.bioinformatics.babraham.ac.uk/projects/bismark/bismark_v0.14.3.tar.gz"
bismark_tar  = "#{archive}/#{File.basename( bismark_link )}"
bismark_dir  = "#{software}/bismark_v0.14.3"

remote_file bismark_tar do
    action :create_if_missing
    source bismark_link
end

bash "extract_bismark" do
    code "tar xf #{bismark_tar} -C #{software}"
    not_if "#{Dir.exists?( bismark_dir )}"
end

link "#{bin}/bismark" do
  to "#{bismark_dir}/bismark"
end

link "#{bin}/bismark_genome_preparation" do
  to "#{bismark_dir}/bismark_genome_preparation"
end
