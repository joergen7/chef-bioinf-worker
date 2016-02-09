#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: deseq
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chef-bioinf-worker::r-base"

directory node.default.dir.software

package "r-cran-gplots"
package "r-cran-xml"

script "install_deseq" do
    interpreter "Rscript"
    code <<-SCRIPT
source( "http://bioconductor.org/biocLite.R" )
biocLite( "DESeq" )
    SCRIPT
    not_if "#{Dir.exists?( "/usr/local/lib/R/site-library/DESeq" )}"
end