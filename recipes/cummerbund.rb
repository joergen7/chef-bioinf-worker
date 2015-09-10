#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: cummerbund
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::r_base"

package "r-bioc-cummerbund"