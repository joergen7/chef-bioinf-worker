#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: deeptools
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

package "python-pip"

bash "install_deeptools" do
  code "pip install deeptools"
  not_if "#{File.exists?( "/usr/local/bin/bamCoverage" )}"
end
