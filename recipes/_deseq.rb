#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: _deseq
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

rlib = node.default.dir.rlib

include_package "_r"

package "r-cran-gplots"

script "install_deseq" do
    interpreter "Rscript"
    code <<-SCRIPT
.libPaths( "#{rlib}" )
source( "http://bioconductor.org/biocLite.R" )
biocLite( "DESeq" )
    SCRIPT
    not_if "#{Dir.exists?( "#{rlib}/DESeq" )}"
end