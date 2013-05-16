psgi_application 'psgi starman application' do
    operator            'Starman'
    enable_service      'off'
    application_user    'app'
    application_home    '/tmp/psgi/starman'
    script              'starman.psgi'
    nproc               '2'
    action              'install'
end

service 'app' do
  action :restart
end

psgi_application 'psgi starman application' do
    operator            'Starman'
    application_user    'app'
    application_home    '/tmp/psgi/starman'
    script              'starman.psgi'
    ignore_failure      false
    action              'test'
end

