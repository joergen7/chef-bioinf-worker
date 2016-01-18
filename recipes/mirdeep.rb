#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: mirdeep
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

mirdeep_link = "https://www.mdc-berlin.de/10663315/de/research/research_teams/systems_biology_of_gene_regulatory_elements/resources/miRDeep.tgz"
mirdeep_tar = "#{node.dir.archive}/#{File.basename( mirdeep_link )}"
mirdeep_dir  = "#{node.dir.software}/miRDeep"
pl_list = ["auto_blast", "blastoutparse", "blastparselect", "excise_candidate", "filter_alignments", "miRDeep", "overlap", "permute_structure"] 


remote_file mirdeep_tar do
  action :create_if_missing
  source mirdeep_link
  retries 1
end

bash "extract_mirdeep" do
  code "tar xf #{mirdeep_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( mirdeep_dir )}"
end

pl_list.each { |pl|

  link "#{node.dir.bin}/#{pl}.pl" do
    to "#{mirdeep_dir}/#{pl}.pl"
  end
}


