#
# Cookbook Name:: ga_proxy_google
# Recipe:: default
#
# Copyright (c) 2016 Sean McGowan, All Rights Reserved.
ga_haproxy 'default'

frontend_name = 'main'
frontend = node['haproxy']['frontends'][frontend_name]
ga_haproxy_frontend frontend_name do
  instance_name 'default'
  socket frontend['socket']
  default_backend frontend['default_backend']
  action :enable
end

backend_name = 'google'
backend = node['haproxy']['backends'][backend_name]
ga_haproxy_backend backend_name do
  instance_name 'default'
  servers backend['servers']
  options backend['options']
  action :enable
end
