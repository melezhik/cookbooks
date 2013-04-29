directory '/tmp/psgi' do
  action :delete
  recursive true
end

directory '/tmp/psgi' do
  action :create
end


psgi_application 'my application' do
        operator            'Catalyst'
        enable_service      false
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/app.psgi'
        daemon_name         'app'
        socket              '/tmp/app-socket.fcgi'
        environment({ "FOO" => "100" })
        perl5lib        [ 'cpanlib/lib/perl5' ]
        nproc           2
        proc_title      'my-app'
        mount           '/'
        config          '/home/user/app/MyApplication/app.conf'
        debug           1
        plackup_environment 'deployment'
        install_dir         '/tmp/psgi'
        action              'install'      
end


