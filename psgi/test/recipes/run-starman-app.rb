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
end

psgi_application 'psgi starman application' do
    server              'Starman'
    application_user    'app'
    application_home    '/tmp/psgi/starman'
    script              'app.psgi'
    ignore_failure      false
    action              'test'
end

