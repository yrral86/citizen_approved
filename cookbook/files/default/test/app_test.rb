require 'minitest/spec'

describe_recipe 'citizen_approved::app' do
  include Minitest::Chef::Assertions
  include Minitest::Chef::Context
  include Minitest::Chef::Resources
  include Chef::Mixin::ShellOut

  it 'listens on port 80' do
    shell_out('lsof -n -i :80 | grep LISTEN').exitstatus.must_equal 0
  end 

  it 'passes a smoke test' do
    ['/'].each do |r|
      shell_out("wget -qO /dev/null http://#{node.ipaddress}/#{r}").exitstatus.must_equal 0
    end
  end
end
