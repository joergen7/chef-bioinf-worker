#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: cutadapt
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

package "python-pip"
package "python-dev"

bash "extract_cufflinks" do
    code "pip install cutadapt"
    not_if "#{File.exists?( "/usr/local/bin/cutadapt" )}"
end
