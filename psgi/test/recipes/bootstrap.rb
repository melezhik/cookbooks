include_recipe 'nginx'

include_recipe 'cpan::bootstrap'

package 'mc'

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

cpan_client 'Starman' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
  force true
end

cpan_client 'Twiggy' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  force true
  action :install
end

directory '/tmp/psgi' do
    recursive true
    action :delete
end

%w{ app catalyst dancer default starman twiggy fcgi }.each do |id|

    user "psgi-#{id}-user"

    directory "/tmp/psgi/#{id}" do
        action :create
        owner "psgi-#{id}-user"
        recursive true
    end
end

%w{ starman twiggy fcgi }.each do |id|
    cookbook_file "/tmp/psgi/#{id}/app.psgi" do
        source 'test.psgi'
        user "psgi-#{id}-user"
    end
    cookbook_file "/tmp/psgi/#{id}/app.conf" do
        source 'test.conf'
        user "psgi-#{id}-user"
    end
end


service 'nginx' do
  action :start
end

cookbook_file '/etc/nginx/sites-available/app.conf' do
    source 'app_nginx.conf'
    owner 'root'
    group 'root'
    mode '644'
end


link '/etc/nginx/sites-enabled/app.conf' do
    to '/etc/nginx/sites-available/app.conf'
end

service 'nginx' do
  action :reload
end


