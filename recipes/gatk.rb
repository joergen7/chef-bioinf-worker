#
# Cookbook Name:: chef-bioinf-worker
# Recipe:: gatk
#
# Copyright (c) 2015 Jörgen Brandt, All Rights Reserved.

gatk_github_link = "https://github.com/broadgsa/gatk-protected.git"
gatk_vsn = "3.4"
gatk_dir = "#{node.dir.software}/gatk-protected"

include_recipe "chef-bioinf-worker::java"

package "git"
package "maven"

directory node.dir.software

git "git_clone_openms_src" do
  action :checkout
  repository gatk_github_link
  revision gatk_vsn
  destination gatk_dir
  retries 4
  timeout 1200
end


# TODO: http://gatkforums.broadinstitute.org/discussion/4023/setting-up-your-dev-environment-maven-and-intellij-for-gatk-3

bash "build_gatk" do
  code "mvn clean package"
  cwd gatk_dir
  not_if ""
end
