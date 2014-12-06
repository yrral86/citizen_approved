require 'minitest/spec'

describe_recipe 'hackathon::mysql_master' do
  include Minitest::Chef::Assertions
  include Minitest::Chef::Context
  include Minitest::Chef::Resources
  include Chef::Mixin::ShellOut

  it 'runs mysql' do
    service('mysql').must_be_running
  end

  it 'authenticates as the hackathon mysql user' do
    assert shell_out("mysql -r -B -N -Dhackathon -uhackathon -p#{node['hackathon']['db']['password']} -e 'SHOW TABLES'").exitstatus.must_equal 0
  end
end
