#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _snpeff
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


snpeff_link = "http://downloads.sourceforge.net/project/snpeff/snpEff_v4_1e_core.zip"
snpeff_zip  = "#{archive}/#{File.basename( snpeff_link )}"
snpeff_dir  = "#{software}/snpEff"

remote_file snpeff_zip do
    action :create_if_missing
    source snpeff_link
end

bash "extract_snpeff" do
    code "unzip -o #{snpeff_zip} -d #{software}"
    not_if "#{Dir.exists?( snpeff_dir )}"
end

file "#{bin}/snpEff" do
    content <<-SCRIPT
#!/usr/bin/env bash
java -jar #{snpeff_dir}/snpEff.jar $@
    SCRIPT
    mode "0755"
end
