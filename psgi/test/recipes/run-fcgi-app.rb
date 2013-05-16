cookbook_file '/tmp/psgi/app/app.psgi' do
    source 'test.psgi'
    user 'app'
end

cookbook_file '/tmp/psgi/app/app.conf' do
    source 'test.conf'
    user 'app'
end


cookbook_file '/etc/nginx/sites-available/app.conf' do
    source 'app_nginx.conf'
    owner 'root'
    group 'root'
    mode '644'
end

psgi_application 'my application' do
    operator            'Catalyst'
    enable_service      'off'
    application_user    'app'
    application_home    '/tmp/psgi/app'
    script              'app.psgi'
    proc_title          'app'
    nproc               '2'
    proc_manager        'FCGI::ProcManager'
    config              '/tmp/psgi/app/app.conf'
    action              'install'
end

service 'app' do
  action :restart
end

psgi_application 'my application' do
        operator            'Catalyst'
        application_user    'app'
        application_home    '/tmp/psgi/app'
        script              'app.psgi'
        config              '/tmp/psgi/app/app.conf'
        ignore_failure      false
        action              'test'
end

