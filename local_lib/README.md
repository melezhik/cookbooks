DESCRIPTION
===========

[cpan](http://search.cpan.org/perldoc?CPAN) modules resource provider
  
PREREQUISITES
=============
  I assume you have a [cpan](http://search.cpan.org/perldoc?CPAN) client installed on your system. Run recipe local_lib::bootstrap
  to install prerequisites
  
    include_recipe 'local_lib::bootstrap'


USAGE
=====
    include_recipe 'local_lib'
    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
    end

ACTIONS
=======

* `install` - install module
* `test` - test module, don't install
* `reload_cpan_index` - reload cpan client indexes

ATTRIBUTES
==========

* `install_type` - whether install as cpan module or application : 'cpan_module', 'application'
* `user` - a user name that we should change to before installing
* `group` - a group name that we should change to before installing
* `version` - a version of module, if '0' then install only if module does not exist
* `install_base` - install base
* `install_path` -  install path, array of install pathes
* `dry_run` - whether to run in dry-run mode or not, default - false 
* `force` - whether to run install process in force mode, default - false
* `from_cookbook` - whether to look up distributive in (cookbook file)[http://wiki.opscode.com/display/chef/Resources#Resources-CookbookFile]

EXAMPLES OF USAGE
=================

fake install
------------
    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        dry_run true 
    end



do not install, only run tests
------------------------------
    local_lib_install 'CGI' do
        action 'test'
        install_type 'cpan_module'
        user 'root'
        group 'root'
    end



force install
-------------

    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        force true 
    end



install by version or higher
----------------------------

    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        version '3.55' 
    end


install only if module not exists
---------------------------------

    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        version '0' 
    end


install from tarball
--------------------

    local_lib_install 'Moose-1.24.tar.gz' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        from_cookbook  'moose'
    end

install into given install_base
-------------------------------

    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        install_base '/some/where/else'
    end


install into given install_base + cwd
-------------------------------------

    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        install_base 'mydir'
        cwd '/home/alex/'
    end



install with given install_path
-------------------------------

    local_lib_install 'Module' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
        install_path ["htdocs=#{ENV['PWD']}/htdocs/"]
    end

install application from current working directory
--------------------------------------------------

    local_lib_install 'my application' do
        action 'install'
        user 'root'
        group 'root'
        install_type 'application'
    end

install under not privileged user
---------------------------------

    # would install into $PWD/cpablib directory
    local_lib_install 'my application' do
        action 'install'
        install_type 'application'
        user 'user'
        group 'users'
        install_base 'cpanlib'  
    end

reload cpan indexes
-------------------

    local_lib_install 'reload cpan index' do
        action 'reload_cpan_index'
        user 'user'
        group 'users'
    end

