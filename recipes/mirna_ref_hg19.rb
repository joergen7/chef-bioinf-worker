#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: mirna_ref_hg19
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

ref_dir = "#{node.dir.data}/mirna_ref_hg19"
mti_url = "http://mirtarbase.mbc.nctu.edu.tw/cache/download/6.1/hsa_MTI.xlsx"
annot_url = "ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_human/release_19/gencode.v19.annotation.gtf.gz"
ref_vsn = "21"
id_list = ["hairpin.fa.gz",
           "mature.fa.gz",
           "genomes/hsa.gff3"
          ]

directory node.dir.data
directory ref_dir

id_list.each { |id|
	
  url = "ftp://mirbase.org/pub/mirbase/#{ref_vsn}/#{id}"

  remote_file "#{ref_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end

}

remote_file "#{ref_dir}/#{File.basename( annot_url )}" do
  action :create_if_missing
  source annot_url
  retries 1
end

remote_file "#{ref_dir}/#{File.basename( mti_url )}" do
  action :create_if_missing
  source mti_url
  retries 1
end
