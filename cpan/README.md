[![Build Status](https://travis-ci.org/melezhik/cookbooks-test.png?branch=master)](https://travis-ci.org/melezhik/cpan-test)  

DESCRIPTION
===

[cpan](http://search.cpan.org/perldoc?CPAN) modules resource provider

PREREQUISITES
===
A little prerequisites are required. Run `cpan::bootstrap` recipe to satisfy
  - [curl](http://curl.haxx.se/)
  - [App::cpanminus](http://search.cpan.org/perldoc?App::cpanminus)
  - [CPAN](http://search.cpan.org/perldoc?CPAN)
  - [local::lib](http://search.cpan.org/perldoc?local::lib)
  

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

* `cwd` - specifies current working directory where installation process runs, default value is `/tmp/`
* `dry_run` - specifies whether to run installation process in dry-run mode or not, default value is `false`
* `environment` - specifies Hash with environment variables exported to installation process
* `force` - specifies whether to run installation process in force mode, default - false
* `from_cookbook` - specifies cookbook, where distributive stored at. Check out [chef cookbook_file resource documentation](http://docs.opscode.com/chef/resources.html#cookbook-file)
* `user`/`group` - specifies a user/group for installation process
* `inc` - specifies perl @INC array
* `install_base` - specifies installation base
* `install_path` - specifies installation paths
* `install_type` - specifies installation type : cpan_module, application; default - application
* `module_name` - specifies the name of cpan module to check version against when install, useful when installing from http url or cookbook
* `version` - specifies version of module to install, see also `module_name` parameter
   * if version defined as `version '0'` - installs only if module is not installed yet
   * if version defined as `version 'version-number'` - installs by version and higher
   * if version defined as `version '=version-number'` - installs exact version

EXAMPLES OF USAGE
===

## fake install

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        dry_run true 
        install_type 'cpan_module'
        action 'install'
    end



## does not install, only run tests

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        install_type 'cpan_module'
        action 'test'
    end



## force install

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        force true 
        install_type 'cpan_module'
        action 'install'
    end



## installs version or higher

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        version '3.55' 
        install_type 'cpan_module'
        action 'install'
    end


## installs only if module is not installed yet

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        version '0' 
        install_type 'cpan_module'
        action 'install'
    end

## installs exact version of module

    # exact version installation is available only for install from cookbook or from http url

    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/MA/MARKSTOS/CGI.pm-3.59.tar.gz' do
        user 'root'
        group 'root'
        module_name 'CGI'
        version '=3.59'
        action 'install'
    end

    cpan_client 'Moose-1.24.tar.gz' do
        user 'root'
        group 'root'
        from_cookbook  'moose'
        module_name 'Moose'
        version '=1.24'
        action 'install'
    end


## installs distributive stored in cookbook

    cpan_client 'Moose-1.24.tar.gz' do
        user 'root'
        group 'root'
        from_cookbook  'moose'
        install_type 'cpan_module'
        action 'install'
    end

## installs distributive stored in cookbook with version check

    cpan_client 'Moose-1.24.tar.gz' do
        user 'root'
        group 'root'
        from_cookbook  'moose'
        module_name 'Moose'
        version '1.24'
        action 'install'
    end

## installs distributive  strored remotely

    # only http protocol now is supported:
    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/MA/MARKSTOS/CGI.pm-3.59.tar.gz' do
        user 'root'
        group 'root'
        action 'install'
    end

## installs distributive  strored remotely with version check

    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/MA/MARKSTOS/CGI.pm-3.58.tar.gz' do
        user 'root'
        group 'root'
        module_name 'CGI'
        version '3.59'
        action 'install'
    end

## installs into given installation base

    cpan_client 'CGI' do
        user 'root'
        group 'root'
        install_base '/some/where/else'
        install_type 'cpan_module'
        action 'install'
    end


## installs into given installation base, relative to given cwd

    # will install into '/home/alex/mydir'
    cpan_client 'CGI' do
        user 'root'
        group 'root'
        install_base 'mydir'
        cwd '/home/alex/'
        install_type 'cpan_module'
        action 'install'
    end



## installs with given install paths

    # will override settings for `htdocs` and `config` elements
    cpan_client 'Module' do
        user 'root'
        group 'root'
        install_path ["htdocs=#{ENV['PWD']}/htdocs/", "config=#{ENV['PWD']}/etc/"]
        install_type 'cpan_module'
        action 'install'
    end

## installs distributive unpacked in current working directory

    cpan_client 'my application' do
        user 'root'
        group 'root'
        install_type 'application'
        action 'install'
    end

## installs under not privileged user

    # will install into $PWD/cpanlib directory
    cpan_client 'my application' do
        install_type 'application'
        user 'user'
        group 'users'
        install_base 'cpanlib'  
        action 'install'
    end

## reloads cpan indexes

    cpan_client 'reload cpan index' do
        user 'user'
        group 'users'
        action 'reload_cpan_index'
    end


## Features

Other examples (cucumber features) may be found at [cpan-test project](https://github.com/melezhik/cpan-test/)


