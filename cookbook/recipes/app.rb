mysql_master = search(:node, "chef_environment:#{node.chef_environment}"' AND run_list:recipe\[hackathon\:\:mysql_master\]').first || node

group 'hackathon'
user 'hackathon' do
  home '/opt/hackathon'
  gid 'hackathon'
  supports :manage_home => true
end

# dependencies
include_recipe 'build-essential'
package 'git'
package 'libmysqlclient-dev'

# for development only
package 'libsqlite3-dev' if node.chef_environment == 'development'

# set up ruby/rvm
### this is not working anyway for some reason
#node.set['rvm']['installs'] = {
#  'hackathon' => {
#    'install_rubies' => true,
#    'default_ruby' => '2.0.0',
#    'rubies' => ['1.9.3-p547', '2.0.0']
#  }
#}
#include_recipe 'rvm::user'

include_recipe 'nginx'
include_recipe 'nginx::passenger'

deploy 'hackathon' do
  repo node['hackathon']['app']['repo']
  revision node['hackathon']['app']['revision']
  deploy_to '/opt/hackathon'
  user 'hackathon'
  environment "RACK_ENV" => node.chef_environment
  before_migrate do
    execute "cp -a /opt/hackathon/current/vendor ." do
      cwd release_path
      only_if 'stat /opt/hackathon/current/vendor'
      notifies :run, 'execute[bundle install]', :immediately
    end

    execute 'bundle install' do
      command 'bundle install --path vendor/bundle --without=cookbook'
      cwd release_path
      user 'hackathon'
    end

    if mysql_master['hackathon']['db']['seeded'] == false
      execute "bundle exec rake db:schema:load" do
        cwd release_path
        user 'hackathon'
      end
      mysql_master.set_unless['hackathon']['db']['seeded'] = true
      mysql_master.save
    end

    template 'config.yml' do
      path "#{release_path}/db/config.yml"
      owner 'hackathon'
      group 'hackathon'
      variables({
        :env => node.chef_environment,
        :db_adapter => 	'mysql',
        :db_host => mysql_master.ipaddress,
        :db_database => 'hackathon',
        :db_username => 'hackathon',
        :db_password => mysql_master['hackathon']['db']['password'] 
      })
    end

  end
  migration_command 'bundle exec rake db:migrate'
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

