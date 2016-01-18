#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: mirdeep2
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

mirdeep2_link = "https://www.mdc-berlin.de/10663315/de/research/research_teams/systems_biology_of_gene_regulatory_elements/resources/miRDeep.tgz"
mirdeep2_tar = "#{node.dir.archive}/#{File.basename( mirdeep2_link )}"
mirdeep2_dir  = "#{node.dir.software}/miRDeep"
pl_list = ["auto_blast", "blastoutparse", "blastparselect", "excise_candidate", "filter_alignments", "miRDeep", "overlap", "permute_structure"] 


remote_file mirdeep2_tar do
  action :create_if_missing
  source mirdeep2_link
  retries 1
end

bash "extract_mirdeep2" do
  code "tar xf #{mirdeep2_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( mirdeep2_dir )}"
end

pl_list.each { |pl|

  link "#{node.dir.bin}/#{pl}.pl" do
    to "#{mirdeep2_dir}/#{pl}.pl"
  end
}


