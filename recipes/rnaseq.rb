#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: rnaseq
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_common"
include_recipe "chef-bioinf-worker::_sratools"
include_recipe "chef-bioinf-worker::_fastqc"
include_recipe "chef-bioinf-worker::_tophat"
include_recipe "chef-bioinf-worker::_cufflinks"
include_recipe "chef-bioinf-worker::_samtools"
include_recipe "chef-bioinf-worker::_cummerbund"