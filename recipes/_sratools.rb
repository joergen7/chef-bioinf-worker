#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _sratools
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


sratools_link = "http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.4.2-4/sratoolkit.2.4.2-ubuntu64.tar.gz"
sratools_tar  = "#{archive}/#{File.basename( sratools_link )}"
sratools_dir  = "#{software}/sratoolkit.2.4.2-ubuntu64"

remote_file sratools_tar do
    source sratools_link
    action :create_if_missing
end

bash "extract_sratools" do
    code "tar xf #{sratools_tar} -C #{software}"
    not_if "#{Dir.exists?( sratools_dir )}"
end

link "#{bin}/fastq-dump" do
  to "#{sratools_dir}/bin/fastq-dump"
end
