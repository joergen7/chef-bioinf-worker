#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _annovar
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


annovar_link = "http://www.openbioinformatics.org/annovar/download/0wgxR2rIVP/annovar.latest.tar.gz"
annovar_tar  = "#{archive}/#{File.basename( annovar_link )}"
annovar_dir  = "#{software}/annovar"

remote_file annovar_tar do
    source annovar_link
    action :create_if_missing
end

bash "extract_annovar" do
    action :nothing
    code "tar xf #{annovar_tar} -C #{software}"
    not_if Dir.exists?( annovar_dir )
end

link "#{bin}/annotate_variation.pl" do
  to "#{annovar_dir}/annotate_variation.pl"
end

link "#{bin}/convert2annovar.pl" do
  to "#{annovar_dir}/convert2annovar.pl"
end
