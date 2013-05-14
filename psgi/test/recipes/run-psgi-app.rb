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

psgi_application 'my application' do
        operator            'Catalyst'
        enable_service      'off'
        application_user    'root'
        application_home    '/tmp/app/'
        script              'app.psgi'
        proc_title          'app'
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


