require 'minitest/spec'

describe_recipe 'citizen_approved::mysql_master' do
  include Minitest::Chef::Assertions
  include Minitest::Chef::Context
  include Minitest::Chef::Resources
  include Chef::Mixin::ShellOut

  it 'runs mysql' do
    service('mysql').must_be_running
  end

  it 'authenticates as the citizen_approved mysql user' do
    assert shell_out("mysql -r -B -N -Dcitizen_approved -ucitizen_approved -p#{node['citizen_approved']['db']['password']} -e 'SHOW TABLES'").exitstatus.must_equal 0
  end
end
