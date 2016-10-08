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
  it { should be_listening.with('tcp') }
end

describe ha_proxy_stat('google1') do
  its(:check_status) { should match(/^L7/) }
  its(:check_code) { should eq 200 }
  its(:status) { should eq 'UP' }
end

describe command('curl -isfm 3 172.16.100.100') do
  its(:stdout) { should match(%r{^HTTP/1\.1 200 OK}) }
  its(:stdout) { should match(%r{<title>Google</title>}) }
end

describe command('curl -isfm 3 "172.16.100.100/search?q=site%3Awikipedia.org+foo+bar&hl=en"') do
  its(:stdout) { should match(%r{^HTTP/1\.1 200 OK}) }
  its(:stdout) { should match(%r{<title>site:wikipedia\.org foo bar - Google Search</title>}) }
end
