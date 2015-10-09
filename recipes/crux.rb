#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: crux
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

crux_src_dir = "#{node.dir.software}/crux-src"
crux_build_dir = "#{node.dir.software}/crux-build"

crux_repository = "http://svn.code.sf.net/p/cruxtoolkit/code/crux/trunk"
crux_revision = "16823"


directory node.dir.software

package "subversion"
package "gcc"
package "g++"
package "cmake"

# checkout crux
#subversion "checkout_crux" do
#  action :checkout
#  repository crux_repository
#  revision crux_revision
#  destination crux_src_dir
#  retries 1
#end

# checkout crux
bash "checkout_crux" do
  code <<-SCRIPT
rm -rf #{crux_src_dir}
svn checkout #{crux_repository}@#{crux_revision} #{crux_src_dir}
  SCRIPT
  not_if "#{File.exists?( "#{crux_src_dir}/CMakeLists.txt" )}"
  retries 1
end

# configure crux
bash "configure_crux" do
  code "cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=#{crux_build_dir}"
  cwd crux_src_dir
  not_if "#{File.exists?( "#{crux_src_dir}/Makefile" )}"
  retries 1
end

# build crux
bash "build_crux" do
  code "make"
  cwd crux_src_dir
  not_if "#{File.exists?( "#{crux_src_dir}/src/crux" )}"
  retries 1
end

# copy binaries in build path
bash "install_crux" do
  code "make install"
  cwd crux_src_dir
  not_if "#{Dir.exists?( crux_build_dir )}"
  retries 1
end

link "#{node.dir.bin}/crux" do
  to "#{crux_build_dir}/bin/crux"
end

link "#{node.dir.bin}/xlink-assign-ions" do
  to "#{crux_build_dir}/bin/xlink-assign-ions"
end

link "#{node.dir.bin}/xlink-score-spectrum" do
  to "#{crux_build_dir}/bin/xlink-score-spectrum"
end

