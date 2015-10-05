#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: hg19
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

hg19_dir = "#{node.dir.data}/hg19"

hg19_large = [
"chr1",
"chr2",
"chr3",
"chr4",
"chr5",
"chr6",
"chr7",
"chr8",
"chr9",
"chr10",
"chr11",
"chr12",
"chr13",
"chr14",
"chr15",
"chr16",
"chr17",
"chr18",
"chr19",
"chr20",
"chr21",
"chr22",
"chrX",
"chrY"
]

hg19_small = [
"chr1_gl000191_random",
"chr1_gl000192_random",
"chr4_ctg9_hap1",
"chr4_gl000193_random",
"chr4_gl000194_random",
"chr6_apd_hap1",
"chr6_cox_hap2",
"chr6_dbb_hap3",
"chr6_mann_hap4",
"chr6_mcf_hap5",
"chr6_qbl_hap6",
"chr6_ssto_hap7",
"chr7_gl000195_random",
"chr8_gl000196_random",
"chr8_gl000197_random",
"chr9_gl000198_random",
"chr9_gl000199_random",
"chr9_gl000200_random",
"chr9_gl000201_random",
"chr11_gl000202_random",
"chr17_ctg5_hap1",
"chr17_gl000203_random",
"chr17_gl000204_random",
"chr17_gl000205_random",
"chr17_gl000206_random",
"chr18_gl000207_random",
"chr19_gl000208_random",
"chr19_gl000209_random",
"chr21_gl000210_random",
"chrM",
"chrUn_gl000211",
"chrUn_gl000212",
"chrUn_gl000213",
"chrUn_gl000214",
"chrUn_gl000215",
"chrUn_gl000216",
"chrUn_gl000217",
"chrUn_gl000218",
"chrUn_gl000219",
"chrUn_gl000220",
"chrUn_gl000221",
"chrUn_gl000222",
"chrUn_gl000223",
"chrUn_gl000224",
"chrUn_gl000225",
"chrUn_gl000226",
"chrUn_gl000227",
"chrUn_gl000228",
"chrUn_gl000229",
"chrUn_gl000230",
"chrUn_gl000231",
"chrUn_gl000232",
"chrUn_gl000233",
"chrUn_gl000234",
"chrUn_gl000235",
"chrUn_gl000236",
"chrUn_gl000237",
"chrUn_gl000238",
"chrUn_gl000239",
"chrUn_gl000240",
"chrUn_gl000241",
"chrUn_gl000242",
"chrUn_gl000243",
"chrUn_gl000244",
"chrUn_gl000245",
"chrUn_gl000246",
"chrUn_gl000247",
"chrUn_gl000248",
"chrUn_gl000249"
]

directory node.dir.data
directory hg19_dir

hg19_large.each { |id|
	
  url = "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/#{id}.fa.gz"
  
  remote_file "#{hg19_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
  
  bash "gunzip #{id}" do
    code "gunzip -k #{id}.fa.gz"
    cwd hg19_dir
    not_if "#{File.exists?( "#{hg19_dir}/#{id}.fa" ) || File.exists?( "#{hg19_dir}/hg19.tar" )}"
  end
}

hg19_small.each { |id|
	
  url = "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/#{id}.fa.gz"
  
  remote_file "#{hg19_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
}

bash "hg19_concatenate_small_fa" do
  code "cat #{hg19_small.map { |id| "#{id}.fa.gz" }.join( " " )} | gunzip -c > small.fa"
  cwd hg19_dir
  not_if "#{File.exists?( "#{hg19_dir}/small.fa" ) || File.exists?( "#{hg19_dir}/hg19.tar" )}"
end

bash "hg19_tar_fa" do
  code "tar --remove-files -cf hg19.tar #{hg19_large.map { |id| "#{id}.fa" }.join( " " )} small.fa"
  cwd hg19_dir
  not_if "#{File.exists?( "#{hg19_dir}/hg19.tar" )}"
end
  
