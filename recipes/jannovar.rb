#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: jannovar
#
# Copyright (c) 2016 Jörgen Brandt, All Rights Reserved.

jannovar_githuburl = "https://github.com/charite/jannovar.git"
jannovar_vsn       = "v0.17"
jannovar_dir       = "#{node["dir"]["software"]}/jannovar-#{jannovar_vsn[1,5]}"

# recipe dependencies
include_recipe "chef-bioinf-worker::java"

# directories
directory node["dir"]["software"]

# packages

package "git"
package "maven"

git "git_clone_jannovar" do
  action :checkout
  repository jannovar_githuburl
  destination jannovar_dir
  revision jannovar_vsn
end

bash "compile_jannovar" do
  code "mvn clean package"
  cwd jannovar_dir
end