#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: samtools
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# package "samtools"

samtools_vsn = "1.3"

samtools_link = "http://downloads.sourceforge.net/project/samtools/samtools/#{samtools_vsn}/samtools-#{samtools_vsn}.tar.bz2"
samtools_tar  = "#{node.dir.archive}/#{File.basename( samtools_link )}"
samtools_dir  = "#{node.dir.software}/samtools-#{samtools_vsn}"


directory node.dir.archive
directory node.dir.software

package "gcc"
package "libncurses5-dev"

remote_file samtools_tar do
  action :create_if_missing
  source samtools_link
  retries 1
end

bash "extract_samtools" do
  code "tar xf #{samtools_tar} -C #{node.dir.software}"
  not_if "#{Dir.exists?( samtools_dir )}"
end

bash "compile_samtools" do
  code "make"
  cwd samtools_dir
  not_if "#{File.exists?( "#{samtools_dir}/samtools" )}"
end

link "#{node.dir.bin}/samtools" do
  to "#{samtools_dir}/samtools"
end