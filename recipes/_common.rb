#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: common
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

# refresh package sources
bash "apt-get_update" do
    code "apt-get update"
end

# create directories
# directory node.default.dir.software
# directory node.default.dir.archive
# directory node.default.dir.jar
# directory node.default.dir.rlib

# auxiliary packages
# package "unzip"
# package "g++"