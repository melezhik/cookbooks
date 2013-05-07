# pinto Cookbook
Installs, configures Pinto 

# recipes
* application - installs Pinto application

## attributes 
may be overridden to alter recipe behaviour 

* `pinto.bootstrap.home`, the directory where Pinto is installed at, default value is '#{ENV\["HOME"]}/opt/local/pinto'
* `pinto.bootstrap.user`, the user which Pinto installation files belongs to, default value is 'root'
* `pinto.bootstrap.user`, the group which Pinto installation files belongs to, default value is 'root'
* `pinto.bootstrap.repo_url`, default value is 'http://stratopan.com:2700/Stratopan/Pinto/Production'



