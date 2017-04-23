require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end


describe service('zentral') do
  it { should be_enabled }
  it { should be_running }
end  
describe service('zentral-workers') do
  it { should be_enabled }
  it { should be_running }
end  
describe service('zentral-gunicorn') do
  it { should be_enabled }
  it { should be_running }
end  

describe file('/var/_zentral/zentral/server/manage.py') do
  it { should be_executable }
end

describe file('/var/log/zentral/gunicorn.err') do
  its(:content) { should match /Starting gunicorn / }
  its(:content) { should match /Listening at: / }
  its(:content) { should_not match /Error/ }
end

