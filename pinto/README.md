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



