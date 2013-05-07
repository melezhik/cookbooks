# pinto Cookbook
Installs, configures Pinto 

# recipes

* pinto::application - installs Pinto application

# attributes 
may be overridden to alter recipe behaviour 

* `pinto.bootstrap.home` - the directory where Pinto is installed at, default value is _$HOME/opt/local/pinto_
* `pinto.bootstrap.user` - the user which Pinto installation files belongs to, default value is _root_
* `pinto.bootstrap.user` - the group which Pinto installation files belongs to, default value is _root_
* `pinto.bootstrap.repo_url` - url for Pinto stratopan repository, default value is _http://stratopan.com:2700/Stratopan/Pinto/Production_


# tested on
* CentOS-6.3-x86_64-minimal, Chef 10.14.2
* Debian, Chef 11.4.4
* Ubuntu 10.04.1 LTS, Chef 11.4.4 

# stable release
http://community.opscode.com/cookbooks/pinto

