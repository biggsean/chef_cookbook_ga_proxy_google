require 'spec_helper'

describe 'ga_proxy_google::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'does something' do
    skip 'Replace this with meaningful tests'
  end
end

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
