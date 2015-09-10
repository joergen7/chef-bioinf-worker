#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: cufflinks
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin

cufflinks_link = "http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz"
cufflinks_tar  = "#{archive}/#{File.basename( cufflinks_link )}"
cufflinks_dir  = "#{software}/cufflinks-2.2.1.Linux_x86_64"

directory node.default.dir.software
directory node.default.dir.archive

remote_file cufflinks_tar do
    action :create_if_missing
    source cufflinks_link
end

bash "extract_cufflinks" do
    code "tar xf #{cufflinks_tar} -C #{software}"
    not_if "#{Dir.exists?( cufflinks_dir )}"
end

link "#{bin}/cufflinks" do
  to "#{cufflinks_dir}/cufflinks"
end

link "#{bin}/cuffmerge" do
  to "#{cufflinks_dir}/cuffmerge"
end

link "#{bin}/cuffdiff" do
  to "#{cufflinks_dir}/cuffdiff"
end

link "#{bin}/gtf_to_sam" do
  to "#{cufflinks_dir}/gtf_to_sam"
end

link "#{bin}/cuffcompare" do
  to "#{cufflinks_dir}/cuffcompare"
end

