require 'chef/provisioning/fog_driver'

env='test'

machine_batch do
  %w{app db}.each do |r|
     machine "hackathon-#{env[0]}-#{r}-01" do
      chef_environment env
      recipe 'hackathon'
      recipe 'minitest-handler'
    end
  end
end

machine "hackathon-#{env[0]}-db-01" do
  recipe 'hackathon::mysql_master'
end

machine "hackathon-#{env[0]}-app-01" do
  recipe 'hackathon::app'
end
