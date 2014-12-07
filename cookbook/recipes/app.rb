#find the mysql_master node
mysql_master = search(:node, "chef_environment:#{node.chef_environment}"' AND run_list:recipe\[citizen_approved\:\:mysql_master\]').first || node

group 'citizen_approved'
user 'citizen_approved' do
  home '/opt/citizen_approved'
  gid 'citizen_approved'
  supports :manage_home => true
end

# dependencies
package 'git'
package 'libmysqlclient-dev'
package 'nodejs'

# set up ruby/rvm
execute 'gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3' do
  environment 'HOME' => '/opt/citizen_approved'
  cwd '/opt/citizen_approved'
  user 'citizen_approved'
end

node.set['rvm']['installs'] = {
  'citizen_approved' => {
    'install_rubies' => true,
    'default_ruby' => '1.9.3-p547',
    'rubies' => ['1.9.3-p547', '2.0.0']
  }
}
include_recipe 'rvm::user'

#set up nginx/passenger
include_recipe 'nginx'
include_recipe 'nginx::passenger'

#deploy citizen_approved
deploy 'citizen_approved' do
  repo node['citizen_approved']['app']['repo']
  revision node['citizen_approved']['app']['revision']
  deploy_to '/opt/citizen_approved'
  user 'citizen_approved'
  environment "RAILS_ENV" => node.chef_environment
  before_migrate do
    execute "cp -a /opt/citizen_approved/current/vendor ." do
      cwd release_path
      only_if 'stat /opt/citizen_approved/current/vendor'
      notifies :run, 'execute[bundle install]', :immediately
    end

    execute 'bundle install' do
      command 'bundle install --path vendor/bundle --without=cookbook'
      cwd release_path
      user 'citizen_approved'
    end

    template 'database.yml' do
      path "#{release_path}/config/database.yml"
      owner 'citizen_approved'
      group 'citizen_approved'
      variables({
        :env => node.chef_environment,
        :db_adapter => 	'mysql',
        :db_host => mysql_master.ipaddress,
        :db_database => 'citizen_approved',
        :db_username => 'citizen_approved',
        :db_password => mysql_master['citizen_approved']['db']['password'] 
      })
    end

    unless mysql_master['citizen_approved']['db']['seeded'] == true
      execute "bundle exec rake db:migrate && bundle exec rake db:seed" do
        cwd release_path
        user 'citizen_approved'
      end
      mysql_master.set_unless['citizen_approved']['db']['seeded'] = true
      mysql_master.save
    end

  end
  migration_command "export RAILS_ENV=#{node.chef_environment}; bundle exec rake db:migrate"
  migrate true
  restart_command do 
    execute "touch #{release_path}/restart.txt"
  end
  symlinks({})
  symlink_before_migrate({})
  create_dirs_before_symlink([])
  purge_before_symlink([])
  action :deploy
end

