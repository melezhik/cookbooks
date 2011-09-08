DESCRIPTION
===========

local::lib provider -- install application / cpan module via local::lib
  
REQUIREMENTS
============
  I assume you have a cpan client installed on your system. Run recipe local_lib::bootstrap
  to install prerequisites
  
    include_recipe 'local_lib::bootstrap'  

ATTRIBUTES
==========

USAGE
=====

     include_recipe 'local_lib'
     
hello world example
-------------------
    local_lib_install 'CGI' do
        action 'install'
        install_type 'cpan_module'
        user 'root'
        group 'root'
    end

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
