#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: qiime
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

package "build-essential"
package "python-dev"
package "python-pip"
package "libfreetype6-dev"
package "libxft-dev"
package "gfortran"
package "libopenblas-dev"
package "liblapack-dev"

bash "install_numpy" do
  code "pip install numpy"
  not_if "#{Dir.exists?( "/usr/local/lib/python2.7/dist-packages/numpy" )}"
end

bash "install_qiime" do
  code "pip install qiime"
  not_if "#{File.exists?( "/usr/local/bin/print_qiime_config.py" )}"
end
