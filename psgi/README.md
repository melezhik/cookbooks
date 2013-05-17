# Synopsis

Configures and runs psgi application

# Prerequisites
* [Plack](http://search.cpan.org/perldoc?Plack)
* a chosen web server cpan module should be installed ( see  list in the `web servers supported` section )

# Features

## web servers supported
- [FCGI](http://search.cpan.org/perldoc?FCGI)
- [Starman](http://search.cpan.org/perldoc?Starman) 

## web frameworks supported
- [Catalyst](http://search.cpan.org/perldoc?Catalyst)
- [Jifty](http://search.cpan.org/perldoc?Jifty)
- [Dancer](http://search.cpan.org/perldoc?Dancer)


# Resources
psgi_application

# Resource parameters
- `operator` (Catalyst|Dancer|Jifty), specify web framework to use, optional
- `server` (FCGI|Starman), specify web server to use, default value is **FCGI**
- `application_user`, change to this user name before starting the process
- `application_home`, absolute path to directory holding application home
- `enable_service`, whether to add service to run levels, default value is **on**. To not enable service set this parameter to 'off'
- `script` - absolute path to psgi script
- `daemon_name`, optional, if not set evaluated as base-name from `script` 
- `daemon_path` - absolute path to daemon, default value is path to system installed [plackup](http://search.cpan.org/perldoc?plackup)
- `socket`, optional
- `environment`, hash containing environmental variables, default value **{}**
- `perl5lib`, array containing perl5lib paths, default value **[]**
- `nproc`, default value `1`, number of child processes to launch
- `proc_manager`, optional, default value is **FCGI::ProcManager**
- `proc_title`, optional, how the processes are seen in process list
- `mount`, optional, mount path, see [Plack::App::URLMap](http://search.cpan.org/perldoc?Plack%3A%3AApp%3A%3AURLMap) for details 
- `config`, absolute path to application configuration file (optional for 'Dancer' operator)
- `debug`, default value **1**
- `plackup_environment`, default value **development**
- `cookbook`, default value `psgi`, the name of cookbook where init script template coming from
- `ignore_failure` - used in action 'test', whether to ignore test failures, if enabled, than test fail will cause chef runtime exception. Default value is **false**

# Usage examples

## run Catalyst application as FCGI standalone server

    psgi_application 'Catalyst FCGI application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'install'      
    end

## run Dancer application as FCGI standalone server

    psgi_application 'Dancer FCGI application' do
        operator            'Dancer'
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        action              'install'      
    end

## run Jifty application as FCGI standalone server

    psgi_application 'Jifty FCGI application' do
        operator            'Jifty'
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'install'      
    end

## run Catalyst application with Starman server, port 5001

    psgi_application 'Catalyst Starman application' do
         server              'Starman'
         application_user    'user'
         application_home    '/home/user/app/MyApplication'
         script              'app.psgi'
         socket              ':5000'
         nproc               '2'
         action              'install'
    end

## using with non system plackup

    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'install'
        daemon_path         '/home/user/app/MyApplication/cpanlib/bin/plackup'      
    end

## run smoke test on installed psgi application 

    psgi_application 'my application' do
        application_user    'user'
        application_group   'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        action              'test'
    end



# Tested on
* Debian-Stable-64-bit, chef 11.4.4
* Ubuntu 12.04.2 LTS, chef 11.4.0

