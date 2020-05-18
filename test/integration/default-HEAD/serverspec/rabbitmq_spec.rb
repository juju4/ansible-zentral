#require 'spec_helper'
require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('rabbitmq-server'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('rabbitmq-server'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('rabbitmq-server'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('rabbitmq-server'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port(5671) do
  it { should be_listening }
end

describe command('rabbitmqctl status'), :if => os[:family] != 'ubuntu' || os[:release] != '20.04' do
  its(:stdout) { should match /Status of node / }
  its(:stdout) { should match /{memory,/ }
  its(:stdout) { should match /{kernel,{net_ticktime/ }
  its(:stdout) { should match /{pid,/ }
  its(:stdout) { should match /{asn1,/ }
  its(:stdout) { should match /{rabbit_common,/ }
  its(:stdout) { should match /\[{rabbit,"RabbitMQ"/ }
  its(:exit_status) { should eq 0 }
  let(:sudo_options) { '-u rabbitmq -H' }
end

describe command('rabbitmqctl status'), :if => os[:family] == 'ubuntu' && os[:release] == '20.04' do
  its(:stdout) { should match /Status of node / }
  its(:stdout) { should match /RabbitMQ version: / }
  its(:stdout) { should match /Erlang configuration: / }
  its(:stdout) { should match /Cluster heartbeat timeout \(net_ticktime\): / }
  its(:stdout) { should match /Calculation strategy: / }
  its(:stdout) { should match /Interface: 127.0.0.1, port: 5671, protocol: amqp\/ssl/ }
  its(:exit_status) { should eq 0 }
  let(:sudo_options) { '-u rabbitmq -H' }
end

describe command('rabbitmqctl authenticate_user guest guest') do
  its(:stdout) { should_not match /Error: failed to authenticate user/ }
  its(:exit_status) { should eq 0 }
  let(:sudo_options) { '-u rabbitmq -H' }
end

describe command('rabbitmqctl eval \'ssl:versions().\'') do
  its(:stdout) { should match /tlsv1.2/ }
  its(:exit_status) { should eq 0 }
  let(:sudo_options) { '-u rabbitmq -H' }
end

