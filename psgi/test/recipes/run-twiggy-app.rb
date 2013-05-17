psgi_application 'twiggy application' do
    server              'Twiggy'    
    enable_service      'off'
    application_user    'app'
    application_home    '/tmp/psgi/twiggy'
    script              'app.psgi'
    daemon_name         'twiggy-psgi'
    socket              ':5001'
    action              'install'
end

psgi_application 'test twiggy application' do
    application_user    'app'
    application_home    '/tmp/psgi/twiggy'
    script              'app.psgi'
    action              'test'
end

service 'twiggy-psgi' do
  action :restart
end


