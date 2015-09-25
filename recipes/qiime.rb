#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: qiime
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::numpy"

package "libfreetype6-dev"
package "libxft-dev"
package "gfortran"
package "libopenblas-dev"
package "liblapack-dev"


bash "install_qiime" do
  code "pip install qiime"
  not_if "#{File.exists?( "/usr/local/bin/print_qiime_config.py" )}"
  retries 1
end
