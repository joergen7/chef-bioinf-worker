#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bsseq
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

include_recipe "chef-bioinf-worker::r-base"

directory node.default.dir.software

package "r-cran-scales"

script "install_deseq" do
    interpreter "Rscript"
    code <<-SCRIPT
source( "http://bioconductor.org/biocLite.R" )
biocLite( "bsseq" )
    SCRIPT
    not_if "#{Dir.exists?( "/usr/local/lib/R/site-library/bsseq" )}"
end
