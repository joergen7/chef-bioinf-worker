#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: mirdeep
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_common"
include_recipe "chef-bioinf-worker::_fastqc"
include_recipe "chef-bioinf-worker::_mirdeep2"
include_recipe "chef-bioinf-worker::_deseq"