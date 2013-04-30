# Description

configures and runs psgi application as fastcgi server

# Features

## web servers supported
- FCGI (more coming soon)

## web frameworks supported
- [Catalyst](http://search.cpan.org/perldoc?Catalyst)
- [Jifty](http://search.cpan.org/perldoc?Jifty)
- [Dancer](http://search.cpan.org/perldoc?Dancer)


# Definitions
psgi_application


# Definitions parameters
- `operator` (Catalyst|Dancer|Jifty), default value `Catalyst`
- `application_user`, change to this username before starting the process
- `application_home`, absolute path to directory holding application home
- `enable_service`, whether to add service to run levels, default `on`
- `script` - absolute path to psgi script
- `daemon_name`, optional, if not set evaluted as basename from `script` 
- `daemon_path` - absolute path to daemon, optional, default value is path to system installed [plackup](http://search.cpan.org/perldoc?plackup)
- `socket`, optional
- `environment`, default value `{}`, hash containing environmental variables
- `perl5lib`, default value `[]`, array containing perl5lib paths
- `nproc`, default value `1`, number of child processes to launch
- `proc_manager`, optional, default value is `FCGI::ProcManager`
- `proc_title`, optional, how the processes are seen in process list
- `mount`, default value `nil` 
- `config`, absolute path to application configuration file, optional for operator => 'Dancer'
- `debug`, default value `1`
- `plackup_environment`, default value `development`
- `cookbook`, default value `psgi`, the name of cookbook where init script template coming from
- `ignore_failure` - used in action 'test', whethe to ignore test failures, is enabled, than test fail will cause chef runtime exception. Default value is 'true'

# Usage example

    # run Catalyst Application (default flavour)
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'install'      
    end

    # run Dancer application
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        operator            'Dancer'
        action              'install'      
    end

    # run Jifty application
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        operator            'Jifty'
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
        ignore_failure      false
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


