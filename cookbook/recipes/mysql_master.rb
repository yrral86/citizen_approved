::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['mysql']['server_root_password'] = secure_password
node.set_unless['mysql']['server_debian_password'] = secure_password
node.set_unless['citizen_approved']['db']['password'] = secure_password
include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

mysql_database 'citizen_approved' do
  connection mysql_connection_info
  action :create
end

mysql_database_user 'citizen_approved' do
  connection mysql_connection_info
  password node['citizen_approved']['db']['password']
  database_name 'citizen_approved'
  host '%'
  privileges [:all]
  action :grant
end
