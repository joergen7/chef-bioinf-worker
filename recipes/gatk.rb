# coding: utf-8
#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: gatk
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

gatk_tar = "#{node.dir.archive}/GenomeAnalysisTK-3.5.tar.bz2"
gatk_dir = "#{node.dir.software}/gatk-3.5"
gatk_bin = "#{node.dir.bin}/gatk"

include_recipe "chef-bioinf-worker::java"

directory node.dir.archive
directory node.dir.software
directory gatk_dir

cookbook_file gatk_tar do
  source "GenomeAnalysisTK-3.5.tar.bz2"
end

bash "extract_gatk" do
  code "tar xjf #{gatk_tar} -C #{gatk_dir}"
end

file gatk_bin do
  content "java -Xmx32g -jar #{gatk_dir}/GenomeAnalysisTK.jar $@"
  mode "0755"
end
