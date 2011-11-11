# Description
- Configures catalyst as fastcgi server 
- Configures apache virtual host for running catalyst fastcgi server

# Platforms
- ubuntu
- gentoo

# Requirements
- [apache cookbook](https://github.com/opscode/cookbooks/tree/master/apache2)
- [catalyst cookbook](https://github.com/opscode/cookbooks/tree/master/catalyst)


# Attributes
* `catalyst_fastcgi.service_name` - name of your catalyst application, default is 'foo'
* `catalyst_fastcgi.server_name` - name of virtual host server, default is 'foo.x'
* `catalyst_fastcgi.start_service` - true|false, whether to try to start application when configuring is done, default value `false`
* `catalyst_fastcgi.application.user` - a user name that we should change to before starting application, default is 'foo'
* `catalyst_fastcgi.application.group` - a group name that we should change to before starting application, default is '/tmp/foo'
* `catalyst_fastcgi.application.home` - a home dir where catalyst application resides, default is '/tmp/foo'
* `catalyst_fastcgi.application.script` - a name of script to start applicationm, an absolute path to your application  will be constructed with application_home/script/application_script, default is foo_fastcgi.pl'
* `catalyst_fastcgi.application.perl5lib` - an array of perl5lib pathes, default is []
* `catalyst_fastcgi.catalyst_config` - a path to catalyst config file, default is '/tmp/foo/foo.conf'
* `catalyst_fastcgi.nproc` - Integer, a number of processes will be launched when application start in fastcgi mode, default is 2
* `catalyst_fastcgi.envvars` - a hash of environment vars, passed to application environment, default is { :CATALYST_DEBUG => 1 }
* `catalyst_fastcgi.proc_manager` - a perl class, implimenting Fast CGI Process ProcManager
* `catalyst_fastcgi.socket` - a socket, application will be binded to, default is '/tmp/foo.socket'


