#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: variant_call
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_common"
include_recipe "chef-bioinf-worker::_bowtie2"
include_recipe "chef-bioinf-worker::_samtools"
include_recipe "chef-bioinf-worker::_varscan"
include_recipe "chef-bioinf-worker::_annovar"
include_recipe "chef-bioinf-worker::_snpeff"
