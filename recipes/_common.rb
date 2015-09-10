#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: common
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# refresh package sources
bash "apt-get_update" do
    code "apt-get update"
end
