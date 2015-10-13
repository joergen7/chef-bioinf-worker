#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: tandem
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

tandem_link = "ftp://ftp.thegpm.org/projects/tandem/source/tandem-linux-15-04-01-1.zip"
tandem_zip  = "#{node.dir.archive}/#{File.basename( tandem_link )}"
tandem_dir  = "#{node.dir.software}/tandem-linux-15-04-01-1"


directory node.dir.archive
directory node.dir.software

package "unzip"
package "g++"
package "libexpat1-dev"

remote_file tandem_zip do
  action :create_if_missing
  source tandem_link
  retries 1
end

bash "extract_tandem" do
  code <<-SCRIPT
unzip -o #{tandem_zip} -d #{node.dir.software}
rm #{tandem_dir}/bin/fasta_pro.exe
rm #{tandem_dir}/bin/tandem.exe
  SCRIPT
  not_if "#{Dir.exists?( tandem_dir )}"
end

bash "build_tandem.exe" do
  code "make"
  cwd "#{tandem_dir}/src"
  not_if "#{File.exists?( "#{tandem_dir}/bin/tandem.exe" )}"
end

bash "build_fasta_pro.exe" do
  code "make EXECUTABLE=../bin/fasta_pro.exe"
  cwd "#{tandem_dir}/src"
  not_if "#{File.exists?( "#{tandem_dir}/bin/fasta_pro.exe" )}"
end

link "#{node.dir.bin}/tandem.exe" do
  to "#{tandem_dir}/bin/tandem.exe"
end

link "#{node.dir.bin}/fasta_pro.exe" do
  to "#{tandem_dir}/bin/fasta_pro.exe"
end
