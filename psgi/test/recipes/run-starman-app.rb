psgi_application 'psgi starman application' do
    server              'Starman'
    enable_service      'off'
    application_user    'psgi-starman-user'
    application_home    '/tmp/psgi/starman'
    script              'app.psgi'
    daemon_name         'starman-psgi'
    socket              ':5000'
    nproc               '2'
    action              'install'
end

psgi_application 'test starman application' do
    application_user    'psgi-starman-user'
    application_home    '/tmp/psgi/starman'
    script              'app.psgi'
    action              'test'
end

service 'starman-psgi' do
  action :restart
  provider node[:psgi][:service][:provider]
end

service 'starman-psgi' do
  action :start
  provider node[:psgi][:service][:provider]
end


