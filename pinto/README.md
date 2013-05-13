# pinto Cookbook
Installs, configures Pinto 

# recipes

* pinto::application - installs Pinto application in standalone mode
* pinto::server - installs Pinto server (should be run after pinto::application recipe), **now works only in centos**

# attributes 
may be overridden to alter recipe behaviour 

* `pinto.bootstrap.home` - the directory where Pinto is installed at, default value is _'$HOME/opt/local/pinto'_
* `pinto.bootstrap.user` - the user which Pinto installation files belongs to, default value is _'root'_
* `pinto.bootstrap.user` - the group which Pinto installation files belongs to, default value is _'root'_
* `pinto.bootstrap.repo_url` - url for Pinto stratopan repository, default value is _'http://stratopan.com:2700/Stratopan/Pinto/Production'_


*  pinto.server.repo_root - the path to the root directory of your Pinto repository. The repository must already exist at this location. This attribute is required. default value _$HOME/opt/local/pinto/repo_
*  pinto.server.host - pinto server bind host, default value is _'0.0.0.0'_
*  pinto.server.port - pinto server bind port, default value is _'5000'_
*  pinto.server.workers - number of pinto server workers, default value is _'3'_


# tested on
* CentOS-6.3-x86_64-minimal, Chef 10.14.2
* Debian-6.0.4-64-bit, Chef 11.4.4
* Ubuntu 10.04.1 LTS, Chef 11.4.4 

# current release
http://community.opscode.com/cookbooks/pinto

