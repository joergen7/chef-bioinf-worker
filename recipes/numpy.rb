#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: numpy
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

package "build-essential"
package "python-dev"
package "python-pip"

bash "install_numpy" do
  code "pip install numpy"
  not_if "#{Dir.exists?( "/usr/local/lib/python2.7/dist-packages/numpy" )}"
  retries 1
end

