#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: annovar
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


annovar_link = "http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz"
annovar_tar  = "#{node.dir.archive}/#{File.basename( annovar_link )}"
annovar_dir  = "#{node.dir.software}/annovar"




directory node.dir.archive
directory node.dir.software


remote_file annovar_tar do
  source annovar_link
  action :create_if_missing
  retries 1
end

bash "extract_annovar" do
  code "tar xf #{annovar_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( annovar_dir )}"
end

link "#{node.dir.bin}/annotate_variation.pl" do
  to "#{annovar_dir}/annotate_variation.pl"
end

link "#{node.dir.bin}/convert2annovar.pl" do
  to "#{annovar_dir}/convert2annovar.pl"
end
