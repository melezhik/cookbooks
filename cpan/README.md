DESCRIPTION
===

[cpan](http://search.cpan.org/perldoc?CPAN) modules resource provider
  
PREREQUISITES
===
1)  I assume you have a [cpan](http://search.cpan.org/perldoc?CPAN) client installed on your system.
2)  Run recipe `cpan::bootstrap` to ensure all dependencies are met:

      include_recipe 'cpan::bootstrap'

## ATTRIBUTES used in cpan::bootstrap recipe

* `cpan.minimal_version` - minimal required version of cpan client 
* `cpan.download_url` - url to download fresh cpan client 

BASIC USAGE
===
    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
    end

RESOURCE ACTIONS
===

* `install` - install module or application 
* `test` - test module, don't install it
* `reload_cpan_index` - reload cpan client indexes

RESOURCE ATTRIBUTES
===

* `install_type` - whether to install as cpan module or as application : cpan_module, application; default - application
* `user` - a user name that we should change to before installing
* `group` - a group name that we should change to before installing
* `version` - a version of module, if 0 then install only if module does not exist, default nil
* `inc` - an Array passed to PERL5LIB environment variable (@INC), default value []
* `install_base` - install base for your installation 
* `install_path` - install path, array of install paths
* `dry_run` - whether to run installation process in dry-run mode or not, default - false 
* `force` - whether to run installation process in force mode, default - false
* `from_cookbook` - whether to look up distributive in [cookbook file](http://wiki.opscode.com/display/chef/Resources#Resources-CookbookFile)
* `environment` - hash which holds environment vars exporting to installation process
* `cwd` - sets the current working directory before running installation process

EXAMPLES OF USAGE
===

fake install
------------
    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        dry_run true 
    end



do not install, only run tests
------------------------------
    cpan_client 'CGI' do
        action 'test'
        install_type 'cpan_module'
        user 'root'
        group 'root'
    end



force install
-------------

    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        force true 
    end



install by version or higher
----------------------------

    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        version '3.55' 
    end


install only if module not exists
---------------------------------

    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        version '0' 
    end


install from tarball stored in cookbook
---------------------------------------

    cpan_client 'Moose-1.24.tar.gz' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        from_cookbook  'moose'
    end

install from tarball remotely stored somewhere
-------------------------------------------------
    # only http protocol now is supported:
    
    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/MA/MARKSTOS/CGI.pm-3.59.tar.gz' do
        action 'install'
        user 'root'
        group 'root'
    end

install into given install_base
-------------------------------

    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        install_base '/some/where/else'
    end


install into given install_base + cwd
-------------------------------------

    # will install into '/home/alex/mydir'
    cpan_client 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        install_base 'mydir'
        cwd '/home/alex/'
    end



install with given install_path
-------------------------------

    # will override settings for `htdocs` and `config` elements
    cpan_client 'Module' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        install_path ["htdocs=#{ENV['PWD']}/htdocs/", "config=#{ENV['PWD']}/etc/"]
    end

install application from current working directory
--------------------------------------------------

    cpan_client 'my application' do
        action 'install'
        user 'root'
        group 'root'
        install_type 'application'
    end

install under not privileged user
---------------------------------

    # will install into $PWD/cpanlib directory
    cpan_client 'my application' do
        action 'install'
        install_type 'application'
        user 'user'
        group 'users'
        install_base 'cpanlib'  
    end

reload cpan indexes
-------------------

    cpan_client 'reload cpan index' do
        action 'reload_cpan_index'
        user 'user'
        group 'users'
    end


Features
===

For complete examples of usage see cucumber features at https://github.com/melezhik/cookbooks/tree/master/cpan/features/

