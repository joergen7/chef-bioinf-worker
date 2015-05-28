#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: misc
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_shrimp"
include_recipe "chef-bioinf-worker::_bismark"
include_recipe "chef-bioinf-worker::_star"
