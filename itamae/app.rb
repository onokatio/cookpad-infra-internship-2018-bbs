execute "apt-get update" do
  run_command("apt-get update")
end

package 'nginx' do
  action :install
end

service 'nginx' do
  action :nothing
end

package 'ruby' do
  action :install
end

package 'ruby-dev' do
  action :install
end

package 'ruby-bundler' do
  action :install
end

package 'build-essential' do
  action :install
end

rails_dep_packages = [
  'zlib1g-dev',
  'libssl-dev',
  'libreadline-dev',
  'libyaml-dev',
  'libxml2-dev',
  'libxslt-dev',
  'sqlite3',
  'libsqlite3-dev',
  'nodejs'
]

rails_dep_packages.each do |pkg|
  package pkg do
    action :install
  end
end

directory '/home/ubuntu/bbs' do
  owner 'ubuntu'
  group 'ubuntu'
  mode '755'
end

directory '/home/ubuntu/bbs/shared' do
  owner 'ubuntu'
  group 'ubuntu'
  mode '755'
end

directory '/home/ubuntu/bbs/releases' do
  owner 'ubuntu'
  group 'ubuntu'
  mode '755'
end

file '/etc/nginx/sites-available/default' do
  action :delete
  notifies :reload, 'service[nginx]'
end

remote_file '/etc/nginx/sites-available/bbs' do
  owner 'root'
  group 'root'
  mode '644'
  notifies :reload, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/bbs' do
  to '/etc/nginx/sites-available/bbs'
end
