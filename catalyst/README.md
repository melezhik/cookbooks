DESCRIPTION
===========

catalyst application resource provider (LWRP)

* start your catalyst application as fast cgi server

Platforms
=========

* gentoo (tested with Calculate Linux Desktop 9.6)
* ubuntu (tested with 11.10 server amd64)

Requirements
============

* This cookbook doesn't have direct dependencies on other cookbooks. 
But you have to be sure that the catalyst application your are going to run 
as fast cgi server at least installed and tested. 

Resources
=========
catalyst_application

Resources Actions
=================

* `install` - install catalyst application

Resource Attributes
===================

* obligatory attrubutes
    * `application_user` - a user name that we should change to before starting application
    * `application_group` - a group name that we should change to before starting application
    * `application_home` - a directory where application and all it's prerequsites live
    * `application_script` - a name of script to start application
    * `catalyst_config` - a path to catalyst config file
* optional attributes
    * `perl5lib` - an array of perl5lib pathes
    * `nproc` - Integer, a number of processes will be launched when application start in fastcgi mode, default value 1
    * `envvars` - a hash of environment vars, passed to application environment
    * `proc_manager` - a perl class, implimenting Fast CGI Process ProcManager, default FCGI::ProcManager
    * `socket` - a socket, application will be binded to


Usage
=====

## 1. Create your catalyst application from the scratch ##

    $ cd /tmp/ 
    $ catalyst.pl Foo
    $ cd Foo
    $ perl Makefile.PL
    $ make
    $ make test
    $ make install

## 2. Deploy it as fast cgi server via catalyst cookbook  ##
        
    catalyst_application 'foo' do
        application_user 'alex'
        application_group 'users'
        application_home '/tmp/Foo'
        application_script 'foo_fastcgi.pl'
        catalyst_config '/tmp/Foo/foo.conf'
        action 'install'
    end

## 3. Now you get it as fastcgi server  ##

    /etc/init.d/foo start
    /etc/init.d/foo stop
    /etc/init.d/foo restart

Links
=====

* http://search.cpan.org/perldoc?Catalyst::Engine::FastCGI

ToDo
====

* add support for more platforms
* add more tests
* add wikis and howtos

