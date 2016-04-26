#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: deeptools
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::numpy"

package "libfreetype6-dev"
package "libxft-dev"
package "libcurl4-gnutls-dev"
package "liblapack-dev"
package "gfortran"

bash "install_deeptools" do
  code "pip install deeptools"
  not_if "#{File.exists?( "/usr/local/bin/bamCoverage" )}"
end
