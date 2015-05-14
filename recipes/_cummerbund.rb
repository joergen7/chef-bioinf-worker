#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _cummerbund
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_package "_r"

package "r-bioc-cummerbund"