#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _squid
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

archive  = node.default.dir.archive
software = node.default.dir.software
bin      = node.default.dir.bin


squid_link = "ftp://selab.janelia.org/pub/software/squid/squid-1.9g.tar.gz"
squid_tar  = "#{archive}/#{File.basename( squid_link )}"
squid_dir  = "#{software}/squid-1.9g"

remote_file squid_tar do
    action :create_if_missing
    source squid_link
end

bash "extract_squid" do
    code "tar xf #{squid_tar} -C #{software}"
    not_if "#{Dir.exists?( squid_dir )}"
end

bash "configure_squid" do
    code "./configure"
    cwd squid_dir
    not_if "#{File.exists?( "#{squid_dir}/Makefile" )}"
end

bash "compile_squid" do
    code "make"
    cwd squid_dir
    # not_if "#{File.exists?( "#{squid_dir}/randfold" )}"
end


