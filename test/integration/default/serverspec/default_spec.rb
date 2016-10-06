require 'spec_helper'
require 'ha_proxy_stat'

describe command('cat /etc/centos-release') do
  its(:stdout) { should match(/\s6\.7/) }
end

describe package('haproxy') do
  it { should be_installed }
end

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end

describe command('haproxy -v') do
  its(:stdout) { should match(/\s1\.[56]\./) }
end

describe port(80) do
  it { should be_listening }
end

describe ha_proxy_stat('google') do
  its(:check_status) { should match(/^L7/) }
  its(:check_code) { should eq 200 }
  its(:status) { should eq 'UP' }
end
