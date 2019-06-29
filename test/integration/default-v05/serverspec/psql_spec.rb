require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

describe command("sudo -u _zentral -H psql -U _zentral -P pager=off zentraldb -c '\\dt'") do
  its(:stdout) { should match /accounts_user/ }
  its(:stdout) { should match /inventory_machinetag/ }
  its(:stdout) { should match /probes_feed/ }
  its(:stdout) { should_not match /No relations found./ }
  its(:stderr) { should_not match /FATAL/ }
  its(:exit_status) { should eq 0 }
## FIXME! fails in Jenkins kitchen/lxd run but fine as interactive. seems sudo options are not applied
#  let(:sudo_options) { '-u _zentral -H' }
end

