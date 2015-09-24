#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: openms
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.


openms_src_dir = "#{node.dir.software}/OpenMS/OpenMS-src"
openms_build_dir = "#{node.dir.software}/OpenMS/OpenMS-build"

contrib_src_dir = "#{node.dir.software}/OpenMS/contrib-src"
contrib_build_dir = "#{node.dir.software}/OpenMS/contrib-build"

package "cmake"
package "g++"
package "autoconf"
package "zlib1g-dev"
package "qt4-dev-tools" do
  retries 1
end
package "patch"
package "libtool"
package "git"
package "libboost-regex-dev"
package "libboost-iostreams-dev"
package "libboost-date-time-dev"
package "libboost-math-dev"
package "libsvm-dev"
package "libglpk-dev"
package "libzip-dev"
package "libxerces-c-dev"
package "libbz2-dev"
package "libeigen3-dev"

directory node.dir.software
directory "#{node.dir.software}/OpenMS"
directory openms_build_dir
directory contrib_build_dir

# fetch OpenMS source code
git "git_clone_openms_src" do
  action :checkout
  repository "https://github.com/OpenMS/OpenMS.git"
  revision "4776889fe40e1b001407b50b9a3de2fd1c175515"
  destination openms_src_dir
end


# fetch OpenMS contrib
git "git_clone_openms_contrib" do
  action :checkout
  repository "https://github.com/OpenMS/contrib.git"
  revision "f6b44d770b6c1b23972a8891753472e60a356253"
  destination contrib_src_dir
end


# build seqan
bash "build_openms_contrib_seqan" do
  code "cmake -DBUILD_TYPE=SEQAN #{contrib_src_dir}"
  cwd contrib_build_dir
  not_if "#{Dir.exists?( "#{contrib_build_dir}/src/seqan-1.4.1" )}"
end

# build wildmagic
bash "build_openms_contrib_wildmagic" do
  code "cmake -DBUILD_TYPE=WILDMAGIC #{contrib_src_dir}"
  cwd contrib_build_dir
  not_if "#{Dir.exists?( "#{contrib_build_dir}/src/WildMagic5" )}"
end

# configure openms
bash "configure_openms" do
  code <<-SCRIPT
cmake -DCMAKE_PREFIX_PATH="#{contrib_build_dir};/usr;/usr/local" -DBOOST_USE_STATIC=OFF #{openms_src_dir}
  SCRIPT
  cwd openms_build_dir
  not_if "#{File.exists?( "#{openms_build_dir}/Makefile" )}"
end

# build openms
bash "build_openms" do
  code "make"
  cwd openms_build_dir
  not_if "#{File.exists?( "#{openms_build_dir}/lib/libOpenMS.so" )}"
  retries 1
end

bash "update_environment" do
  code "echo export LD_LIBRARY_PATH=#{openms_build_dir}/lib >> /etc/environment"
  not_if "grep LD_LIBRARY_PATH /etc/environment"
end
