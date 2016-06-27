#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _common
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

# refresh package sources
bash "apt-get_update" do
    code "apt-get update"
end