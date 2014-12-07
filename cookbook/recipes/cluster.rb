require 'chef/provisioning/fog_driver'

env='test'

machine_batch do
  %w{app db}.each do |r|
     machine "citizen-#{env[0]}-#{r}-01" do
      chef_environment env
      recipe 'citizen'
      recipe 'minitest-handler'
    end
  end
end

machine "citizen-#{env[0]}-db-01" do
  recipe 'citizen::mysql_master'
end

machine "citizen-#{env[0]}-app-01" do
  recipe 'citizen::app'
end
