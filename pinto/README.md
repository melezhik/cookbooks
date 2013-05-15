# pinto Cookbook
Installs, configures Pinto application 

# recipes
* pinto::application - installs Pinto application in standalone mode
* pinto::server - installs Pinto server ( should be run after pinto::application recipe )

# attributes 
may be overridden to alter recipes behaviour 

* `pinto.bootstrap.user` - the user which Pinto installation files belongs to, default value is _'pinto'_
* `pinto.bootstrap.group` - the group which Pinto installation files belongs to, default value is _'pinto'_
* `pinto.bootstrap.home` - the home directory of application user, default value is _'/home/pinto/'_, so application will be installed into `pinto.bootstrap.home/opt/local/pinto`


*  `pinto.server.repo_root` - the path to the root directory of your Pinto repository. The repository must already exist at this location. This attribute is required. default value is _'/home/pinto/opt/local/pinto/repo'_
*  `pinto.server.host` - pinto server bind host, default value is _'0.0.0.0'_
*  `pinto.server.port` - pinto server bind port, default value is _'5000'_
*  `pinto.server.workers` - number of pinto server workers, default value is _'3'_


# tested on
* CentOS-6.4-x86_64, , Chef 10.14.0
* CentOS-6.3-x86_64-minimal, Chef 10.14.2
* Debian-6.0.4-64-bit, Chef 11.4.4
* Ubuntu 10.04.1 LTS, Chef 11.4.4 

# current release
http://community.opscode.com/cookbooks/pinto


# contrubuting 
I use berkshelf for developing / testing pinto cookbook. Berkshelf is a framework for testing/developing chef cooksbooks. So if you one is inerested in contirbuting / hacking, berkshelf is the best way to go ahead.
Next commands will explain how to start. 

## Install berkshelf

    $ gem install berkshelf

## Install latest version of vagrant
Berskhelf requires latest version of vagrant. Visit the Vagrant downloads page - download http://downloads.vagrantup.com/ and download the latest installer for your operating system.

## install vagrant-berkshelf plugin
Second thing we need is berkshelf vagrant plugin. Following command will install the plugin

    $ vagrant plugin install vagrant-berkshelf 
    
## fork cookbooks 

    $ git clone https://github.com/melezhik/cookbooks.git

## run vagrant box 
Following command will boot vagrant virtual machine, deploy pinto on it and run tests.

    $ cd cookbooks/pinto
    $ vagrant up
  
