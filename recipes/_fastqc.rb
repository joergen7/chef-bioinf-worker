#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _fastqc
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chef-bioinf-worker::_java"

package "fastqc" do
    version "0.10.1+dfsg-2"
end
