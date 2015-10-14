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
package "libstdc++5"
package "libstdc++5:i386"

remote_file tandem_zip do
  action :create_if_missing
  source tandem_link
  retries 1
end

bash "extract_tandem" do
  code "unzip -o #{tandem_zip} -d #{node.dir.software}"
  not_if "#{Dir.exists?( tandem_dir )}"
end



bash "set_user_privileges_tandem.exe" do
  code "chmod a+x #{tandem_dir}/bin/tandem.exe"
end

bash "set_user_privileges_fasta_pro.exe" do
  code "chmod a+x #{tandem_dir}/bin/fasta_pro.exe"
end

link "#{node.dir.bin}/tandem.exe" do
  to "#{tandem_dir}/bin/tandem.exe"
end

link "#{node.dir.bin}/fasta_pro.exe" do
  to "#{tandem_dir}/bin/fasta_pro.exe"
end
