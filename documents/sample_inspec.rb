describe host('serverspec.org') do
  it { should be_resolvable }
end

# ping serverspec.org
describe host('serverspec.org') do
  it { should be_reachable }
end

describe interface('eth0') do
  it { should exist }
end

#ifconfig
describe interface('eth0') do
  it { should have_ipv4_address("127.0.0.1") }
  it { should have_ipv4_address("127.0.0.1/24") }
end

#ls -hal /etc/passwd
describe file('/etc/passwd') do
  it { should be_file }
  it { should exist }
  it { should be_owned_by 'root' }
  its('content') { should include 'root' }
  its('mode') { should cmp '0644' }
end

#ls -hal
describe file('/tmp') do
  it { should be_directory }
end

#getent groups |grep root
describe group('root') do
  it { should exist }
  its('gid') { should eq 1001 }
end

#rpm -qa|grep python-backports-1.0-8.el7.x86_64
describe package('python-backports-1.0-8.el7.x86_64') do
  it { should be_installed }
end

# ps aux|grep rcu_sched
describe processes('rcu_sched') do
  its('users') { should eq ['root'] }
  its('states') { should eq ['R<'] }
end

#systemctl |grep postfix
describe service('postfix') do
  it { should be_enabled }
  it { should be_running }
end

#netstat -plnt
describe port(22) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
end

#netstat |grep socket
describe file('/run/systemd/journal/socket') do
  it { should be_socket }
end

#sysctl -a
describe kernel_parameter('kernel.hostname') do
  its('value') { should eq "host" }
end

describe kernel_parameter('kernel.osrelease') do
  its('value') { should eq "3.10.0-693.el7.x86_64" }
end

describe kernel_parameter('kernel.ostype') do
  its('value') { should eq "Linux" }
end

#id
describe user('root') do
  it { should exist }
  its('uid') { should eq 1001 }
  its('home') { should eq '/root' }
end

describe command('id -nu') do
  its('stdout') { should eq 'root' }
end
