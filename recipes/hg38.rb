#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: hg38
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

hg38_dir = "#{node.dir.data}/hg38"

directory node.dir.data
directory hg38_dir

node.data.hg38.large.each { |id|
	
  url = "http://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/#{id}.fa.gz"
  
  remote_file "#{hg38_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
  
  bash "gunzip #{id}" do
    code "gunzip -k #{id}.fa.gz"
    cwd hg38_dir
    not_if "#{File.exists?( "#{hg38_dir}/#{id}.fa" ) || File.exists?( "#{hg38_dir}/hg38.tar" )}"
  end
}

node.data.hg38.small.each { |id|
	
  url = "http://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/#{id}.fa.gz"
  
  remote_file "#{hg38_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
}

bash "concatenate_small_fa" do
  code "cat #{node.data.hg38.small.map { |id| "#{id}.fa.gz" }.join( " " )} | gunzip -c > small.fa"
  cwd hg38_dir
  not_if "#{File.exists?( "#{hg38_dir}/small.fa" ) || File.exists?( "#{hg38_dir}/hg38.tar" )}"
end

bash "tar_fa" do
  code "tar --remove-files -cf hg38.tar #{node.data.hg38.large.map { |id| "#{id}.fa" }.join( " " )} small.fa"
  cwd hg38_dir
  not_if "#{File.exists?( "#{hg38_dir}/hg38.tar" )}"
end
  
