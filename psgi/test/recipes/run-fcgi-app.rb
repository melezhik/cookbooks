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
  provider node[:psgi][:service][:provider]
end

psgi_application 'test fcgi application' do
    application_user    'app'
    application_home    '/tmp/psgi/app'
    script              'app.psgi'
    action              'test'
end

