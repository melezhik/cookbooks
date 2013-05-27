psgi_application 'catalyst fcgi application' do
    operator            'Catalyst'
    enable_service      false
    application_user    'psgi-catalyst-user'
    application_home    '/home/user/app/MyApplication'
    script              '/home/user/app/MyApplication/scripts/app.psgi'
    perl5lib            [ 'cpanlib/lib/perl5' ]
    nproc               2
    proc_title          'my-app'
    mount               '/'
    config              '/home/user/app/MyApplication/app.conf'
    debug                1
    plackup_environment 'deployment'
    install_dir         '/tmp/psgi/catalyst'
    environment({ "FOO" => "100" })
    action              'install'      
end


