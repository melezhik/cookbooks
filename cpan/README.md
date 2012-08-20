DESCRIPTION
===

[cpan](http://search.cpan.org/perldoc?CPAN) modules resource provider
  
PREREQUISITES
===
 - 1)  I assume you have a [cpan](http://search.cpan.org/perldoc?CPAN) client installed on your system.
 - 2)  Run recipe `cpan::bootstrap` to ensure all others dependencies are met:

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

* `cwd` - specifies current working directory where installation process runs
* `dry_run` - whether to run installation process in dry-run mode or not, default - false 
* `environment` - hash which holds environment variables exported to installation process
* `force` - specifies whether to run installation process in force mode, default - false
* `from_cookbook` - specifies cookbook, where distributive stored at [check out cookbook file resource documentation](http://wiki.opscode.com/display/chef/Resources#Resources-CookbookFile)
* `group` - specifies a group name for installation process
* `inc` - an Array passed to PERL5LIB environment variable (@INC), default value []
* `install_base` - specifies install base for installation 
* `install_path` - specifies install paths for installation, Array of Strings
* `install_type` - whether to install as cpan module or as application : cpan_module, application; default - application
* `module_name` - specifies the name of cpan module to check against when doing install, useful when doing install from http url or cookbook
* `group` - specifies a user name for installation process
* `url` - specifies http url with distibutive
* `version` - specifies version of module, if 0 install if only module does not exist, default nil. see also module_name

EXAMPLES OF USAGE
===

fake install
------------
    cpan_client 'CGI' do
        user 'root'
        group 'root'
        dry_run true 
        install_type 'cpan_module'
        action 'install'
    end



do not install, only run tests
------------------------------
    cpan_client 'CGI' do
        user 'root'
        group 'root'
        install_type 'cpan_module'
        action 'test'
    end



force install
-------------

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        force true 
        install_type 'cpan_module'
        action 'install'
    end



install by version or higher
----------------------------

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        version '3.55' 
        install_type 'cpan_module'
        action 'install'
    end


install only if module not exists
---------------------------------

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        version '0' 
        install_type 'cpan_module'
        action 'install'
    end


install distributive stored in cookbook
---------------------------------------

    cpan_client 'Moose-1.24.tar.gz' do
        user 'root'
        group 'root'
        from_cookbook  'moose'
        install_type 'cpan_module'
        action 'install'
    end

install distributive stored in cookbook with version check
-----------------------------------------------------------

    cpan_client 'Moose-1.24.tar.gz' do
        user 'root'
        group 'root'
        from_cookbook  'moose'
        module_name 'Moose'
        version '1.24'
        action 'install'
    end

install from http url
---------------------
    # only http protocol now is supported:
    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/MA/MARKSTOS/CGI.pm-3.59.tar.gz' do
        user 'root'
        group 'root'
        action 'install'
    end

install from http url with version check
----------------------------------------
    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/MA/MARKSTOS/CGI.pm-3.58.tar.gz' do
        user 'root'
        group 'root'
        module_name 'CGI'
        version '3.59'
        action 'install'
    end

install into given install_base
-------------------------------

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        install_base '/some/where/else'
        install_type 'cpan_module'
        action 'install'
    end


install into given install_base with relative_path
--------------------------------------------------

    # will install into '/home/alex/mydir'
    cpan_client 'CGI' do
        user 'root'
        group 'root'
        install_base 'mydir'
        cwd '/home/alex/'
        install_type 'cpan_module'
        action 'install'
    end



install with given install_path
-------------------------------

    # will override settings for `htdocs` and `config` elements
    cpan_client 'Module' do
        user 'root'
        group 'root'
        install_path ["htdocs=#{ENV['PWD']}/htdocs/", "config=#{ENV['PWD']}/etc/"]
        install_type 'cpan_module'
        action 'install'
    end

install application from current working directory
--------------------------------------------------

    cpan_client 'my application' do
        user 'root'
        group 'root'
        install_type 'application'
        action 'install'
    end

install under not privileged user
---------------------------------

    # will install into $PWD/cpanlib directory
    cpan_client 'my application' do
        install_type 'application'
        user 'user'
        group 'users'
        install_base 'cpanlib'  
        action 'install'
    end

reload cpan indexes
-------------------

    cpan_client 'reload cpan index' do
        user 'user'
        group 'users'
        action 'reload_cpan_index'
    end


Features
===

For complete examples of usage see cucumber features at https://github.com/melezhik/cookbooks/tree/master/cpan/features/

