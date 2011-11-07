DESCRIPTION
===========

catalyst application resource provider LWRP

* start your catalyst application as server, now available only `fastcgi` run mode

BASIC USAGE
===========
    catalyst_application 'foo' do
        application_user 'alex'
        application_group 'users'
        application_home '/home/alex/catalyst-applications/foo'
        application_script 'foo_fastcgi.pl'
        action 'install'
    end

RESOURCE ACTIONS
================

* `install` - install catalyst application

RESOURCE ATTRIBUTES
===================

* `application_user` - a user name that we should change to before starting application
* `application_group` - a group name that we should change to before starting application
* `application_home` - a directory where application and all it's prerequsites live
* `application_script` - a name of script to start application (will be looking at `application_home/scripts`)

