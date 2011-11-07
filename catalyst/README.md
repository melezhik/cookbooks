DESCRIPTION
===========

catalyst application resource provider (LWRP)

* start your catalyst application as server, now available only in `fastcgi` run mode

Requirements
============

* Catalyst

BASIC USAGE
===========
    catalyst_application 'foo' do
        application_user 'alex'
        application_group 'users'
        application_home '/home/alex/catalyst-applications/foo'
        application_script 'foo_fastcgi.pl'
        catalyst_config '/home/alex/catalyst-applications/foo.conf'
        action 'install'
    end

RESOURCE ACTIONS
================

* `install` - install catalyst application

RESOURCE ATTRIBUTES
===================

* obligatory attrubutes
    * `application_user` - a user name that we should change to before starting application
    * `application_group` - a group name that we should change to before starting application
    * `application_home` - a directory where application and all it's prerequsites live
    * `application_script` - a name of script to start application
    * `catalyst_config` - a path to catalyst config file
* optional attributes
    * `perl5lib` - an array of perl5lib pathes
    * `nproc` - a number of processes will be launched when application start in fastcgi mode, default value 1
    * `envvars` - a hash of environment vars, passed to application environment
    * `proc_manager` - a perl class, implimenting Fast CGI Process ProcManager, default FCGI::ProcManager
    * `socket` - a socket, application will be binded to
    
Links
=====

* http://search.cpan.org/perldoc?Catalyst::Engine::FastCGI
