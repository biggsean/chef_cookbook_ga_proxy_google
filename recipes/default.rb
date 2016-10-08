#
# Cookbook Name:: ga_proxy_google
# Recipe:: default
#
# Copyright (c) 2016 Sean McGowan, All Rights Reserved.
frontends = node['haproxy']['frontends']
backends = node['haproxy']['backends']
ga_haproxy 'default' do
  frontends frontends
  backends backends
  action :create
end
