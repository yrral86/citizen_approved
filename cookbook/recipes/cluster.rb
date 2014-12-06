require 'chef/provisioning/fog_driver'

env='test'

machine_batch do
  %w{app db}.each do |r|
     machine "citizen_approved-#{env[0]}-#{r}-01" do
      chef_environment env
      recipe 'citizen_approved'
      recipe 'minitest-handler'
    end
  end
end

machine "citizen_approved-#{env[0]}-db-01" do
  recipe 'citizen_approved::mysql_master'
end

machine "citizen_approved-#{env[0]}-app-01" do
  recipe 'citizen_approved::app'
end
