psgi_application 'psgi fcgi application' do
    operator            'Catalyst'
    enable_service      'off'
    application_user    'psgi-fcgi-user'
    application_home    '/tmp/psgi/fcgi'
    script              'app.psgi'
    proc_title          'app'
    nproc               '2'
    proc_manager        'FCGI::ProcManager'
    config              '/tmp/psgi/fcgi/app.conf'
    action              'install'
end

psgi_application 'test fcgi application' do
    application_user    'psgi-fcgi-user'
    application_home    '/tmp/psgi/fcgi'
    script              'app.psgi'
    action              'test'
end

service 'app' do
  action :restart
  provider node[:psgi][:service][:provider]
end

service 'app' do
  action :start
  provider node[:psgi][:service][:provider]
end


