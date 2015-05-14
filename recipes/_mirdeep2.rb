#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _mirdeep2
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_bowtie"
include_recipe "chef-bioinf-worker::_viennarna"
include_recipe "chef-bioinf-worker::_randfold"

package "libpdf-api2-perl"

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


mirdeep2_link = "https://www.mdc-berlin.de/43969303/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep/mirdeep2_0_0_7.zip"
mirdeep2_zip  = "#{archive}/#{File.basename( mirdeep2_link )}"
mirdeep2_dir  = "#{software}/mirdeep2_0_0_7"

remote_file mirdeep2_zip do
    source mirdeep2_link
    action :create_if_missing
end

bash "extract_mirdeep2" do
    code "unzip -o #{mirdeep2_zip} -d #{software}"
    not_if "#{Dir.exists?( mirdeep2_dir )}"
end

link "#{bin}/Rfam_for_miRDeep.fa" do
    to "#{mirdeep2_dir}/Rfam_for_miRDeep.fa"
end

link "#{bin}/perform_controls.pl" do
    to "#{mirdeep2_dir}/perform_controls.pl"
end

link "#{bin}/fastaselect.pl" do
    to "#{mirdeep2_dir}/fastaselect.pl"
end

link "#{bin}/samFLAGinfo.pl" do
    to "#{mirdeep2_dir}/samFLAGinfo.pl"
end

link "#{bin}/remove_white_space_in_id.pl" do
    to "#{mirdeep2_dir}/remove_white_space_in_id.pl"
end

link "#{bin}/excise_precursors_iterative_final.pl" do
    to "#{mirdeep2_dir}/excise_precursors_iterative_final.pl"
end

link "#{bin}/prepare_signature.pl" do
    to "#{mirdeep2_dir}/prepare_signature.pl"
end

link "#{bin}/make_html.pl" do
    to "#{mirdeep2_dir}/make_html.pl"
end

link "#{bin}/extract_miRNAs.pl" do
    to "#{mirdeep2_dir}/extract_miRNAs.pl"
end

link "#{bin}/fastaparse.pl" do
    to "#{mirdeep2_dir}/fastaparse.pl"
end

link "#{bin}/collapse_reads_md.pl" do
    to "#{mirdeep2_dir}/collapse_reads_md.pl"
end

link "#{bin}/rna2dna.pl" do
    to "#{mirdeep2_dir}/rna2dna.pl"
end

link "#{bin}/geo2fasta.pl" do
    to "#{mirdeep2_dir}/geo2fasta.pl"
end

link "#{bin}/select_for_randfold.pl" do
    to "#{mirdeep2_dir}/select_for_randfold.pl"
end

link "#{bin}/bwa_sam_converter.pl" do
    to "#{mirdeep2_dir}/bwa_sam_converter.pl"
end

link "#{bin}/parse_mappings.pl" do
    to "#{mirdeep2_dir}/parse_mappings.pl"
end

link "#{bin}/mirdeep2bed.pl" do
    to "#{mirdeep2_dir}/mirdeep2bed.pl"
end

link "#{bin}/get_mirdeep2_precursors.pl" do
    to "#{mirdeep2_dir}/get_mirdeep2_precursors.pl"
end

link "#{bin}/sanity_check_mapping_file.pl" do
    to "#{mirdeep2_dir}/sanity_check_mapping_file.pl"
end

link "#{bin}/quantifier.pl" do
    to "#{mirdeep2_dir}/quantifier.pl"
end

link "#{bin}/miRDeep2.pl" do
    to "#{mirdeep2_dir}/miRDeep2.pl"
end

link "#{bin}/permute_structure.pl" do
    to "#{mirdeep2_dir}/permute_structure.pl"
end

link "#{bin}/excise_precursors.pl" do
    to "#{mirdeep2_dir}/excise_precursors.pl"
end

link "#{bin}/sanity_check_mature_ref.pl" do
    to "#{mirdeep2_dir}/sanity_check_mature_ref.pl"
end

link "#{bin}/mapper.pl" do
    to "#{mirdeep2_dir}/mapper.pl"
end

link "#{bin}/survey.pl" do
    to "#{mirdeep2_dir}/survey.pl"
end

link "#{bin}/find_read_count.pl" do
    to "#{mirdeep2_dir}/find_read_count.pl"
end

link "#{bin}/fastq2fasta.pl" do
    to "#{mirdeep2_dir}/fastq2fasta.pl"
end

link "#{bin}/make_html2.pl" do
    to "#{mirdeep2_dir}/make_html2.pl"
end

link "#{bin}/convert_bowtie_output.pl" do
    to "#{mirdeep2_dir}/convert_bowtie_output.pl"
end

link "#{bin}/sam_reads_collapse.pl" do
    to "#{mirdeep2_dir}/sam_reads_collapse.pl"
end

link "#{bin}/sanity_check_genome.pl" do
    to "#{mirdeep2_dir}/sanity_check_genome.pl"
end

link "#{bin}/clip_adapters.pl" do
    to "#{mirdeep2_dir}/clip_adapters.pl"
end

link "#{bin}/sanity_check_reads_ready_file.pl" do
    to "#{mirdeep2_dir}/sanity_check_reads_ready_file.pl"
end

link "#{bin}/illumina_to_fasta.pl" do
    to "#{mirdeep2_dir}/illumina_to_fasta.pl"
end

link "#{bin}/install.pl" do
    to "#{mirdeep2_dir}/install.pl"
end

link "#{bin}/miRDeep2_core_algorithm.pl" do
    to "#{mirdeep2_dir}/miRDeep2_core_algorithm.pl"
end
