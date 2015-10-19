#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bdgp6
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


bdgp6_link = "ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Drosophila_melanogaster/Ensembl/BDGP6/Drosophila_melanogaster_Ensembl_BDGP6.tar.gz"
bdgp6_tar = "#{node.dir.archive}/#{File.basename( bdgp6_link )}"
bdgp6_dir = "#{node.dir.data}/BDGP6"

directory node.dir.data
directory node.dir.archive

remote_file bdgp6_tar do
  action :create_if_missing
  source bdgp6_link
  retries 1
end

bash "extract_bdgp6" do
  code <<-SCRIPT
tar xf #{bdgp6_tar} -C #{node.dir.data} Drosophila_melanogaster/Ensembl/BDGP6
mv #{node.dir.data}/Drosophila_melanogaster/Ensembl/BDGP6 #{node.dir.data}/BDGP6
rm -rf #{node.dir.data}/Drosophila_melanogaster
  SCRIPT
  not_if "#{Dir.exists?( bdgp6_dir )}"
end
