#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _bismark
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::bowtie"
include_recipe "chef-bioinf-worker::bowtie2"
include_recipe "chef-bioinf-worker::samtools"

software = node.default.dir.software
bin      = node.default.dir.bin

bismark_githuburl = "https://github.com/joergen7/bismark.git"
bismark_dir       = "#{software}/bismark"

# archive  = node.default.dir.archive
# bismark_link = "http://www.bioinformatics.babraham.ac.uk/projects/bismark/bismark_v0.14.3.tar.gz"
# bismark_tar  = "#{archive}/#{File.basename( bismark_link )}"

# remote_file bismark_tar do
#   action :create_if_missing
#   source bismark_link
# end
#
# bash "extract_bismark" do
#   code "tar xf #{bismark_tar} -C #{software}"
#   not_if "#{Dir.exists?( bismark_dir )}"
# end

directory node.default.dir.software

package "git"

git "git_clone_bismark" do
  action :checkout
  repository bismark_githuburl
  destination bismark_dir
end


link "#{bin}/bismark" do
  to "#{bismark_dir}/bismark"
end

link "#{bin}/bismark_genome_preparation" do
  to "#{bismark_dir}/bismark_genome_preparation"
end

link "#{bin}bismark_methylation_extractor" do
  to "#{bismark_dir}/bismark_methylation_extractor"
end

link "#{bin}/bismark2bedGraph" do
  to "#{bismark_dir}/bismark2bedGraph"
end

link "#{bin}/bismark2report" do
  to "#{bismark_dir}/bismark2report"
end

link "#{bin}/coverage2cytosine" do
  to "#{bismark_dir}/coverage2cytosine"
end

link "#{bin}/deduplicate_bismark" do
  to "#{bismark_dir}/deduplicate_bismark"
end

