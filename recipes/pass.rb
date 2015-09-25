#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: pass
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

pass_link = "http://pass.cribi.unipd.it//download/pass_v2.28.tar.gz"
pass_targz = "#{node.dir.archive}/#{File.basename( pass_link )}"
pass_dir = "#{node.dir.software}/pass_v2.28"

directory node.dir.archive
directory node.dir.software

remote_file pass_targz do
  action :create_if_missing
  source pass_link
  retries 1
end

bash "extract_pass" do
  code <<-SCRIPT
tar xf #{pass_targz} -C #{node.dir.software}
chmod a+rx #{pass_dir}
chmod a+rx #{pass_dir}/bin
chmod a+rx #{pass_dir}/bin/pass_v2.28_I+
  SCRIPT
  not_if "#{Dir.exists?( pass_dir )}"
end

link "#{node.dir.bin}/pass" do
  to "#{pass_dir}/bin/pass_v2.28_I+"
end
