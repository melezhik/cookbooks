# Description
installs, configures, runs psgi application as fastcgi server

# Definitions
psgi_application

# Definitions parameters
- operator `(Catalyst|Dancer)`, default value `Catalyst`
- application_user
- application_home
- script - path to psgi script
- daemon_name, optional
- socket, optional
- environment, default value `{}`
- perl5lib, default value `[]`
- nproc, default value `1`
- proc_manager, default value `nil`
- proc_title, optional
- mount, default value `nil` 
- config 
- debug, default value `1`
- plackup_environment, default value `development`
- cookbook, default value `psgi`


# Usage example

    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'install'      
    end

    # run dancer application
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        operator            'Dancer'
        action              'install'      
    end
    
    # test application
    psgi_application 'my application' do
        application_user    'user'
        application_group   'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'test'      
    end

    # usage with non system plackup
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'install'
        daemon_path         '/home/user/app/MyApplication/cpanlib/bin/plackup'      
    end


