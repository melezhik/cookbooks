#
# Cookbook Name:: dry-run
# Recipe:: default
#

directory node.dryrun.dir do
  action :delete
  recursive true
end


directory node.dryrun.dir do
  action :create
  recursive true
end