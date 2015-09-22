#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: openms
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

openms_dir = "#{node.dir.software}/OpenMS-2.0.0"
openms_targz = "#{node.dir.archive}/OpenMS-2.0.0_src.tar.gz"
openms_link = "http://downloads.sourceforge.net/project/open-ms/OpenMS/OpenMS-2.0/OpenMS-2.0.0_src.tar.gz"

contrib_dir = "#{openms_dir}/contrib"
build_dir = "#{openms_dir}/OpenMS-build"

package "cmake"
package "g++"
package "autoconf"
package "qt4-dev-tools"
package "patch"
package "libtool"
package "make"
package "git"
package "libboost-regex-dev"
package "libboost-iostreams-dev"
package "libboost-date-time-dev"
package "libboost-math-dev"
package "libsvm-dev"
package "libglpk-dev"
package "libzip-dev"
package "zlib1g-dev"
package "libxerces-c-dev"
package "libbz2-dev"

directory node.dir.archive
directory node.dir.software

# fetch from github
# git "git_clone_openms" do
#   action :checkout
#   repository "https://github.com/OpenMS/OpenMS.git"
#   destination openms_dir
# end

# fetch package
remote_file openms_targz do
  action :create_if_missing
  source openms_link
end

# extract package
bash "extract_openms" do
  code "tar xf #{openms_targz} -C #{node.dir.software}"
  not_if "#{Dir.exists?( openms_dir )}"
end

# build zlib
#
# Just building ALL will make the target ZLIB fail. Therefore, we build it
# prior to the other dependencies. In the build run towards ALL, ZLIB will just
# be skipped.
#
bash "build_openms_zlib" do
  code "sudo cmake -DBUILD_TYPE=ZLIB ."
  cwd contrib_dir
end

# build contrib
bash "build_openms_contrib" do
  code "sudo cmake -DBUILD_TYPE=ALL ."
  cwd contrib_dir
end

# build openms
#directory build_dir
#bash "build_openms" do
#  code <<-SCRIPT
#cmake -DCMAKE_PREFIX_PATH="#{contrib_dir};/usr;/usr/local" -DBOOST_USE_STATIC=OFF ..
#  SCRIPT
#  cwd build_dir
#end
