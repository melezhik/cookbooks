# CHANGELOG for pinto

This file is used to list changes made in each version of pinto.


## 0.1.8:

* default.pinto.bootstrap.home is depricated ( effectively evalutaed to /home/default.pinto.bootstrap.home )
* doing *system-wide install* when default.pinto.bootstrap.user == root
* doing *local user install* when default.pinto.bootstrap.root != root
* *local user install* is default one
* removed Time::HiRes and CGI from missed dependencies list ( for centOS )


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
