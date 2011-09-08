#
# Cookbook Name:: local-lib
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory '/tmp/local-lib/' do
  action :delete
  recursive true 
end

directory '/tmp/local-lib/' do
  action :create
  mode '0777'
end

directory '/tmp/local-lib/install' do
  action :create
  mode '0777'
end

cookbook_file '/tmp/local-lib/.modulebuildrc' do
 action :create
 source '.modulebuildrc'
 mode '0644'
end

#unless ENV['SUDO_USER'] 
#  raise "ENV['SUDO_USER'] not defined - cannot do install; do sudo su instead"
#end

#node.default.local_lib.user = ENV['SUDO_USER']
#node.default.local_lib.group = `id -gn $SUDO_USER`.chomp!

#puts "WILL install with rights : user:#{node.local_lib.user} & group:#{node.local_lib.group}"
#puts "default_inc = #{node.local_lib.default_inc}"  
