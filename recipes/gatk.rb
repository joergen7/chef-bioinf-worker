# coding: utf-8
#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: gatk
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

gatk_vsn = "3.6"
gatk_tar = "#{node.dir.archive}/GenomeAnalysisTK-#{gatk_vsn}.tar.bz2"
gatk_dir = "#{node.dir.software}/gatk-#{gatk_vsn}"
gatk_bin = "#{node.dir.bin}/gatk"

include_recipe "chef-bioinf-worker::java"
include_recipe "chef-bioinf-worker::r-base"

package "r-cran-ggplot2"

directory node.dir.archive
directory node.dir.software
directory gatk_dir

cookbook_file gatk_tar do
  source "GenomeAnalysisTK-#{gatk_vsn}.tar.bz2"
end

bash "extract_gatk" do
  code "tar xjf #{gatk_tar} -C #{gatk_dir}"
  not_if "#{File.exists?( "#{gatk_dir}/GenomeAnalysisTK.jar" )}"
end

file gatk_bin do
  content "java -Xmx2g -jar #{gatk_dir}/GenomeAnalysisTK.jar $@"
  mode "0755"
end
