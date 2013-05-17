# CHANGELOG for psgi

This file is used to list changes made in each version of psgi.

## 0.0.11:
* action `:test` - optionally look up string in response body **todo**
* chef minitest -  add test for application with mount parameter **todo**
* chef minitest -  add test for jifty application **todo**
* default value for `operator` is not **Catalyst**, but **nill** **todo**
* `framework` is alias for `operator` parameter **todo**
* lowercase for postfix in socketfile name, in case unix socket **todo**

## 0.0.10:
* do not check Plack version
* big fix for environment variable poluted (action :test)
* refactoring of debian / ubuntu init script
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
* documentation gets more cleare
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
