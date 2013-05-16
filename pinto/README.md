# Synopsis
Installs, configures [Pinto](http://search.cpan.org/perldoc?Pinto) application 

# Recipes
* pinto::application - installs Pinto application in standalone mode
* pinto::server - installs Pinto server ( should be run after pinto::application recipe )

# Attributes 
May be overridden to alter recipes behaviour 

* `pinto.bootstrap.user` - the user which Pinto installation files belongs to, default value is **pinto**.
_Please do not override  pinto.bootstrap.user attributes to 'root' or the recipe will fail!_

* `pinto.bootstrap.group` - the group which Pinto installation files belongs to, default value is **pinto**
* `pinto.bootstrap.home` - the home directory of application user, default value is **/home/pinto/**, so application will be installed into `pinto.bootstrap.home/opt/local/pinto`


*  `pinto.server.repo_root` - the path to the root directory of your Pinto repository. The repository must already exist at this location. Default value is **/home/pinto/opt/local/pinto/repo**
*  `pinto.server.host` - pinto server bind host, default value is **0.0.0.0**
*  `pinto.server.port` - pinto server bind port, default value is **5000**
*  `pinto.server.workers` - number of pinto server workers, default value is **3**


# Tested on
* CentOS-6.4-x86_64, , Chef 10.14.0
* CentOS-6.3-x86_64-minimal, Chef 10.14.2
* Debian-6.0.4-64-bit, Chef 11.4.4
* Ubuntu 10.04.1 LTS, Chef 11.4.4 

# Current release
http://community.opscode.com/cookbooks/pinto

# Contributing 
I use berkshelf for developing / testing pinto cookbook. [Berkshelf](http://berkshelf.com/) is a framework for testing / managing chef cookbooks. 
So if you are interested in contributing, hacking - berkshelf is the best way to go ahead. Next commands will explain how to start. 

## Install berkshelf

    $ gem install berkshelf

## Install vagrant
[Vagrant](http://www.vagrantup.com/) is the tools for running / provisioning VirtualBox machines. 
Berkshelf and Vagrant are tightly integrated. Berskhelf requires latest version of vagrant. 
Visit the Vagrant downloads page - http://downloads.vagrantup.com/ and download the latest installer for your operating system.

## Install vagrant-berkshelf plugin
Second thing we need is berkshelf vagrant plugin. Following command will install the plugin

    $ vagrant plugin install vagrant-berkshelf 
    
## Fork cookbooks 

    $ git clone https://github.com/melezhik/cookbooks.git

## Run vagrant box 
Following command will boot vagrant virtual machine, deploy pinto on it and run tests.

    $ cd cookbooks/pinto
    $ vagrant up
  
## Make changes
Change code and revision your changes running tests again. For standard vagrant work-flow checkout - http://docs.vagrantup.com/v2/

    $ mcedit recipes/application.rb
    $ vagrant provision
    
