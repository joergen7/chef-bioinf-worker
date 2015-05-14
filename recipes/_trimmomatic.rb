#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _trimmomatic
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin

include_recipe "chef-bioinf-worker::_java"

trimmomatic_link = "http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.32.zip"
trimmomatic_zip  = "#{archive}/#{File.basename( trimmomatic_link )}"
trimmomatic_dir  = "#{software}/Trimmomatic-0.32"

remote_file trimmomatic_zip do
    action :create_if_missing
    source trimmomatic_link
end

bash "extract_trimmomatic" do
    code "unzip -o #{trimmomatic_zip} -d #{software}"
    not_if "#{Dir.exists?( trimmomatic_dir )}"
end

file "#{bin}/trimmomatic" do
    content <<-SCRIPT
#!/usr/bin/env bash
java -jar #{trimmomatic_dir}/trimmomatic-0.32.jar $@
    SCRIPT
    mode "0755"
end
