# version 0.0.29
- bootstrap recipe: added centos relate package [pull/16](https://github.com/melezhik/cookbooks/pull/16), thanks to [phoolish](https://github.com/phoolish)

# version 0.0.28
- berkshelf / minitest chef infrastructure has been added 
- messages 'won't install without force' in log file should turn into exception


# version 0.0.27
- cpan::bootstrap have been made multiplatforms - todo
- centos platform now is supported - todo

# version 0.0.26
- have made bootstrap recipe more concise and clear
- cucumber tests have been moved to distinct github project - https://github.com/melezhik/cpan-test/
- few logger/output changes

# version 0.0.25
- cpan index force reload
- explicit cookbook name in metadata (https://github.com/melezhik/cookbooks/pull/5)

# version 0.0.24
- workaround for invalid byte sequence in UTF-8

# version 0.0.23
- fix for unstrusted string hanlding commented (does not work for ruby 1.8.*)
- reload index action implemented now by `reload index` cpan client command
- bootstrap list minimized

# version 0.0.22
- replace Iconv by encode
- do not turn 'ERRORS/WARNINGS FOUND IN PREREQUISITES'  into exception

# version 0.0.21
- turning 'ERRORS/WARNINGS FOUND IN PREREQUISITES' into exception
- cpan::bootstrap - AUTOMATED_TESTING enabled (https://github.com/melezhik/cookbooks/issues/1)

# version 0.0.20
- cpan::bootstrap - added some vital Modules 
- cpan_client - handling untrusted strings with Iconv when grep cpan logs

# version 0.0.19
- default value for cwd is '/tmp/'

# version 0.0.18
- installs exact version now available

# version 0.0.17
- a big refactoring
- `module_name` parameter added 
- version check when doing install from cookbook/url
- documentation cleaned up 


# version 0.0.16
- небольшой рефакторинг кода 

# version 0.0.15
- install from remote tarball by http/ftp url

# version 0.0.14
- raise exception if found "Stopping: 'install' failed" in install_log - workaround for https://github.com/andk/cpanpm/issues/32
- does `rm -rf "/tmp/local-lib/install/#{installed_module}"` in install from tarball to delete already unpacked distro
- bugfix : user, group added to :action `test`

# version 0.0.13
- install summary:
 - improved, fixed and simplified

# version 0.0.12
 - cpan-client: redirect stderr to stdout 
 - made logs more clear
 
# version 0.0.11
 - add cucumber features
 - bugfix for install_path cases
 
# version 0.0.10
 - bugfix : before install create /tmp/local-lib/install directory

# version 0.0.9
 - add documentation
 
# version 0.0.8
 - .modulebuildrc create in :install action instead of cpan::default recipe
 - add cpan_home optional attribute
 - create '/tmp/local_lib/' before doing install

# version 0.0.7
 - bugfix for install from tarball (forgot about cwd while refactoring)
 
# version 0.0.6
 - replace execute resource by bash resources for less verbosity in logs
 - improve after-install summary
 
# version 0.0.5
 - compact log messages

# version 0.0.4
 - log messages are neat and at different levels
 - big fix for access to log files 
 
