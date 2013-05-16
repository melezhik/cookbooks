include_recipe 'cpan::bootstrap'

cpan_client 'Plack' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  version node[:psgi][:plack][:version]
  action :install
end

cpan_client 'FCGI' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
end

cpan_client 'FCGI::ProcManager' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
end

execute 'apt-get update'

package 'nginx'

service 'nginx' do
  action :start
end

link '/etc/nginx/sites-enabled/app.conf' do
    to '/etc/nginx/sites-available/app.conf'
end

service 'nginx' do
  action :reload
end

user 'app'

directory '/tmp/psgi' do
    recursive true
    action :delete
end

%w{default catalyst dancer starman app}.each do |dir|
    directory "/tmp/psgi/#{dir}" do
        action :create
        owner 'app'
        recursive true
    end
end



