require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

describe file('/usr/local/bin/gunicorn'), :if => os[:family] == 'ubuntu' || os[:family] == 'debian' do
  it { should be_file }
  it { should be_executable }
end
describe file('/usr/local/bin/gunicorn'), :if => os[:family] == 'redhat' do
  it { should be_file }
  it { should be_executable }
end

