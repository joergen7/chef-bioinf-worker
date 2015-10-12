#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: annodb_hg38
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

annodb_hg38_dir = "/opt/data/annodb_hg38"


include_recipe "chef-bioinf-worker::annovar"

directory node.dir.data

bash "download_annodb_hg38" do
  code "annotate_variation.pl -downdb -webfrom annovar hg38 #{annodb_hg38_dir}"
  not_if "#{Dir.exists?( annodb_hg38_dir )}"
end
