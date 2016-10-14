#
# Cookbook Name:: ga_proxy_google
# Spec:: default
#
# Copyright (c) 2016 Sean McGowan, All Rights Reserved.

require 'spec_helper'

describe 'ga_proxy_google::default' do
  context 'When attributes are defined, on CentOS 6.7' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '6.7').converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates haproxy service' do
      expect(chef_run).to create_ga_haproxy('default')
    end
    it 'creates haproxy frontend' do
      expect(chef_run).to enable_ga_haproxy_frontend('main').with(
        instance_name: 'default',
        socket: '*:80',
        default_backend: 'google'
      )
    end
    it 'creates haproxy backend' do
      expect(chef_run).to enable_ga_haproxy_frontend('google').with(
        instance_name: 'default',
        servers: [{ name: 'google1', socket: 'www.google.com:80', options: ['check'] }],
        options: [
          'option  httpchk  HEAD / HTTP/1.1\r\nHost:\ www.google.com',
          'http-request set-header Host www.google.com',
          'http-request set-header User-Agent GoogleProxy'
        ]
      )
    end
  end
end
