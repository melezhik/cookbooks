psgi_application 'psgi fcgi application' do
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

psgi_application 'psgi fcgi application' do
    operator            'Catalyst'
    application_user    'app'
    application_home    '/tmp/psgi/app'
    script              'app.psgi'
    config              '/tmp/psgi/app/app.conf'
    ignore_failure      false
    action              'test'
end

