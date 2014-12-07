require 'chef/provisioning/fog_driver'

machine 'citizen-dev' do
  environment 'development'
  recipe 'citizen_approved::all'
end
