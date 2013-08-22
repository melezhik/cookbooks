# CHANGELOG for pinto

This file is used to list changes made in each version of pinto.

## 0.1.10:
- small bug fix in mini test for application recipe, to take into account http proxy issues
- pinto.user_shell attribute added, now pinto application owner is created with this shell
- fix version check in minitest

## 0.1.9:
* default port for pinto server is now 3111
* removed outdated code

## 0.1.8:

* big refactoring 
* default.pinto.bootstrap namespace has been abolished to default.pinto namespace
* default.pinto.bootstrap.home is depricated ( effectively evaluated to ~/local/opt/pinto )
* default.pinto.server.repo_root is depricated ( effectively evaluated to ~/local/opt/pinto/var/ )
* doing *system-wide install* when default.pinto.user == root
* doing *local user install* when default.pinto.root != root
* *local user install* is default one
* removed Time::HiRes and CGI from missed dependencies list ( for centOS ) - https://github.com/thaljef/Pinto/issues/67


## 0.1.7:
* init scripts for debian / ubuntu get refactored
* warning message about installation for 'root' user

## 0.1.6:
* README - add contribution section

## 0.1.5:
* documentation bug fixes

## 0.1.4:
* now installs and runs as the "pinto" user by default - [issues/8](https://github.com/melezhik/cookbooks/issues/8)
* now does standalone installation from http://getpinto.stratopan.com - [issues/9](https://github.com/melezhik/cookbooks/issues/9)
* pinto::server - init script for debian platform

## 0.1.3:

* installs pintod server

## 0.1.2:
* pinto bashrc fixed
* mini::test chef tests imporved

## 0.1.1:
* pinto::application - code from https://raw.github.com/thaljef/Pinto/master/etc/install.sh used as prototype

## 0.1.0:

* Initial release of pinto

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
