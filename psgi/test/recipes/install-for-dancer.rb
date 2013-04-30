directory '/tmp/psgi' do
        action :create
end

psgi_application 'my application' do
    application_user    'user'
    application_home    '/home/user/app/MyApplication'
    script              '/home/user/app/MyApplication/scripts/dancer.psgi'
    config              '/home/user/app/MyApplication/app.conf'
    install_dir         '/tmp/psgi'
    operator            'Dancer'
    enable_service      'off'
    action              'install'      
end

