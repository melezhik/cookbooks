psgi_application 'my application' do
    application_user    'user'
    application_group   'user'
    application_home    '/home/user/app/MyApplication'
    script              '/home/user/app/MyApplication/scripts/app.psgi'
    config      '/home/user/app/MyApplication/app.conf'
    action      'test'
end

