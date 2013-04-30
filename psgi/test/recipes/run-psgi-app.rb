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

psgi_application 'my application' do
        operator            'Catalyst'
        enable_service      'off'
        application_user    'root'
        application_home    '/tmp/app/'
        script              'app.psgi'
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
        application_home    '/tmp/app/'
        script              'app.psgi'
        config              '/tmp/app/app.conf'
        ignore_failure      false
        action              'test'
end


execute "cd /tmp/app && SERVER_PORT=80 SERVER_NAME='127.0.0.1' SCRIPT_NAME='/' REQUEST_METHOD='GET' /usr/local/bin/plackup -s CGI app.psgi | grep '200 OK'"

