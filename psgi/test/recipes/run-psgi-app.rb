directory '/tmp/app/' do
  action :delete
  recursive true
end

directory '/tmp/app/' do
  action :create
end


cookbook_file '/tmp/app/app.psgi' do
  source 'test.psgi'
end

cookbook_file '/tmp/app/app.conf' do
  source 'test.conf'
end

execute 'cpan Plack'

case node['platform_family']
when 'debian'
  execute 'apt-get update'
when 'centos'
  execute 'yum update'
when 'ubuntu'
  execute 'apt-get update'
end

package 'nginx'

service 'nginx' do
  s :start
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

psgi_application 'my application' do
        operator            'Catalyst'
        enable_service      'off'
        application_user    'root'
        application_home    '/tmp/app'
        script              'app.psgi'
        proc_title          'app'
        nproc               '2'
        proc_manager        'FCGI::ProcManager'
        config              '/tmp/app/app.conf'
        action              'install'
end

service 'app' do
  action :restart
end

psgi_application 'my application' do
        operator            'Catalyst'
        application_user    'root'
        application_home    '/tmp/app'
        script              'app.psgi'
        config              '/tmp/app/app.conf'
        ignore_failure      false
        action              'test'
end


