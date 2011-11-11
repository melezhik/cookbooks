Description
===========

catalyst application resource provider (LWRP) 

* start your catalyst application as fastcgi server
* configuration of apache is beyond the scope, but you may consider [my apache cookbook](https://github.com/melezhik/cookbooks/tree/master/apache)

Platforms
=========

* gentoo (tested with Calculate Linux Desktop 9.6)
* ubuntu (tested with 11.10 server amd64)

Requirements
============

* This cookbook doesn't have direct dependencies on other cookbooks. But you have to be sure 
that the catalyst application you are going to run at least installed and tested. 

Resources
=========
catalyst_application

Resources Actions
=================

* `install` - install catalyst application as fastcgi server

Resource Attributes
===================

* obligatory attrubutes
    * `application_user` - a user name that we should change to before starting application
    * `application_group` - a group name that we should change to before starting application
    * `application_home` - a name of script to start application, an absolute path to your application  will be constructed with application_home/application_script
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
        application_home '/tmp/Foo'
        application_script 'foo_fastcgi.pl'
        catalyst_config '/tmp/Foo/foo.conf'
        action 'install'
    end

## 3. Now you have catalyst application running as fastcgi server  ##

    /etc/init.d/foo start
    /etc/init.d/foo stop
    /etc/init.d/foo restart

Links
=====

* http://search.cpan.org/perldoc?Catalyst::Engine::FastCGI - running catalyst app as fastcgi server

ToDo
====

* add support for more platforms
* add more tests
* add wikis and howtos

