#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: mirdeep2
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

mirdeep2_link = "https://www.mdc-berlin.de/43969303/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep/mirdeep2_0_0_7.zip"
mirdeep2_zip = "#{node.dir.archive}/#{File.basename( mirdeep2_link )}"
mirdeep2_dir  = "#{node.dir.software}/mirdeep2_0_0_7"
pl_list = ["bwa_sam_converter", "get_mirdeep2_precursors", "prepare_signature",
           "clip_adapters", "illumina_to_fasta", "quantifier",
           "collapse_reads_md", "remove_white_space_in_id",
           "convert_bowtie_output", "make_html2", "rna2dna",
           "excise_precursors_iterative_final", "make_html", "samFLAGinfo",
           "excise_precursors", "mapper", "sam_reads_collapse",
           "extract_miRNAs", "mirdeep2bed", "sanity_check_genome",
           "fastaparse", "miRDeep2_core_algorithm", "sanity_check_mapping_file",
           "fastaselect", "miRDeep2", "sanity_check_mature_ref",
           "fastq2fasta", "parse_mappings", "sanity_check_reads_ready_file",
           "find_read_count", "perform_controls", "select_for_randfold",
           "geo2fasta", "permute_structure", "survey"
          ] 


remote_file mirdeep2_tar do
  action :create_if_missing
  source mirdeep2_link
  retries 1
end

bash "extract_mirdeep2" do
  code "unzip -o #{mirdeep2_tar} -d #{node.dir.software}"
  not_if "#{Dir.exists?( mirdeep2_dir )}"
end

pl_list.each { |pl|

  link "#{node.dir.bin}/#{pl}.pl" do
    to "#{mirdeep2_dir}/#{pl}.pl"
  end
}


