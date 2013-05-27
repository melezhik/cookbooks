psgi_application 'dancer fcgi application' do
    application_user    'psgi-dancer-user'
    application_home    '/home/user/app/MyApplication'
    script              '/home/user/app/MyApplication/scripts/app.psgi'
    config              '/home/user/app/MyApplication/app.conf'
    install_dir         '/tmp/psgi/dancer'
    operator            'Dancer'
    enable_service      'off'
    action              'install'      
end

