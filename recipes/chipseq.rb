#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: chipseq_worker
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::_common"
include_recipe "chef-bioinf-worker::_trimmomatic"
include_recipe "chef-bioinf-worker::_bwa"
include_recipe "chef-bioinf-worker::_sratools"
include_recipe "chef-bioinf-worker::_peakranger"
include_recipe "chef-bioinf-worker::_samtools"
include_recipe "chef-bioinf-worker::_bedtools"
