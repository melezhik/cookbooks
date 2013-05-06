#
# Cookbook Name:: cpanminus
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node.cpanminus.bootstrap.packages.each do |p|
    package p
end

execute 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus'


