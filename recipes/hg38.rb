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
}

node.data.hg38.small.each { |id|
	
  url = "http://hgdownload.soe.ucsc.edu/goldenPath/hg38/chromosomes/#{id}.fa.gz"
  
  remote_file "#{hg38_dir}/#{File.basename( url )}" do
    action :create_if_missing
    source url
    retries 1
  end
}
