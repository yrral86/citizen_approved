require 'chef/provisioning/fog_driver'

machine 'citizen-dev' do
  chef_environment 'development'
  recipe 'citizen_approved::all'
end
