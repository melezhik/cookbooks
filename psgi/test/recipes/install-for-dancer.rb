directory '/tmp/dancer.psgi' do
        action :create
end

psgi_application 'my application' do
    application_user    'user'
    application_home    '/home/user/app/MyApplication'
    script              '/home/user/app/MyApplication/scripts/foo.psgi'
    config              '/home/user/app/MyApplication/app.conf'
    install_dir         '/tmp/dancer.psgi'
    operator            'Dancer'
    enable_service      'off'
    action              'install'      
end

