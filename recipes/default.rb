#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: default
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::variant_call"
include_recipe "chef-bioinf-worker::chipseq"
include_recipe "chef-bioinf-worker::rnaseq"
include_recipe "chef-bioinf-worker::mirdeep"
include_recipe "chef-bioinf-worker::misc"