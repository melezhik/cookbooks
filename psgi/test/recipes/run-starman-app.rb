psgi_application 'psgi starman application' do
    server              'Starman'
    enable_service      'off'
    application_user    'app'
    application_home    '/tmp/psgi/starman'
    script              'app.psgi'
    daemon_name         'starman-psgi'
    socket              ':5000'
    nproc               '2'
    action              'install'
end

service 'starman-psgi' do
  action :restart
  provider node[:psgi][:service][:provider]
end

psgi_application 'test starman application' do
    application_user    'app'
    application_home    '/tmp/psgi/starman'
    script              'app.psgi'
    action              'test'
end

