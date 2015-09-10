#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _fastqc
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chef-bioinf-worker::java"

package "fastqc"
