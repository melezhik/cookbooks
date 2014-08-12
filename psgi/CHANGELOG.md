# CHANGELOG for psgi

This file is used to list changes made in each version of psgi.

## 0.1.2:
* `test action` - log info for environment variables now is correct  

## 0.1.1:
* use Chef::Provider::Service::Debian provider for debian 

## 0.1.0:
* environment variables now have highest priority

## 0.0.15:
* added notions about loader and backlog parameters
* backlog parameter added for FCGI server

## 0.0.14:
* support for Corona web server  

## 0.0.13:
* `loader` parameter now can be passed to `psgi` resource - see [plackup documenation](http://search.cpan.org/~miyagawa/Plack-1.0030/script/plackup) for details

## 0.0.12:
* debian init scripts are refactored
* now support for centOS
* using upstart init system in ubuntu and centOS
* README - notes about upstart, ubutnu, centOS, debian, etc.

## 0.0.11:
* added 'Twiggy' server
* default value for `operator` is not **Catalyst**, but **nill**
* lower-case for postfix in socket file name, in case unix socket

## 0.0.10:
* do not check Plack version
* big fix for environment variable polluted (action :test)
* re-factoring of debian / ubuntu init script
* action `:test`, `ignore_failures` default value is **false**  
* support for Starman server


## 0.0.8:
* take into account perl5lib when check Plack version

## 0.0.7:
* checks version of Plack ( old versions do not work correctly with FCGI )
* berkshelf / minitest chef infrastructure has been added
* default value for `proc_manager` is FCGI::ProcManager
* `-fcgi` postfix in `proc-title` has been removed

## 0.0.6:
* delete old files

## 0.0.5:
* documentation gets more clear
* `enabled_service` is `on` by default 

## 0.0.4:
* `supports` info fixed
* doc updated 

## 0.0.3:
* added `daemon_path` parameter to `test` action

## 0.0.2:
* new parameter - `daemon_path`, default is `system path to plackup`

## 0.0.1:

* Initial release of psgi

- - - 
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
