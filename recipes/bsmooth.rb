#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: bsmooth
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

bsmooth_githuburl = "https://github.com/joergen7/bsmooth-align"
bsmooth_dir       = "#{node.dir.software}/bsmooth-align"
merman_dir        = "#{bsmooth_dir}/merman"



directory node.dir.software

package "git"
package "g++"

git "git_clone_bmooth" do
  action :checkout
  repository bsmooth_githuburl
  destination bsmooth_dir
end

bash "bsmooth_set_permission" do
  code "chmod a+x #{bsmooth_dir}/bin/bs_merman_align.pl"
end

bash "compile_merman" do
  code "make"
  cwd merman_dir
  not_if "#{File.exists?( "#{merman_dir}/merman" )}"
end

link "#{node.dir.bin}/merman" do
  to "#{merman_dir}/merman"
end

link "#{node.dir.bin}/bs_merman_align.pl" do
  to "#{bsmooth_dir}/bin/bs_merman_align.pl"
end


