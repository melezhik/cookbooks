# Description
- Configures catalyst as fastcgi server 
- Configures apache virtual host for running catalyst fastcgi server

# Platforms
- ubuntu
- gentoo

# Requirements
- [apache cookbook](https://github.com/melezhik/cookbooks/tree/master/catalyst)
- [catalyst cookbook](https://github.com/melezhik/cookbooks/tree/master/catalyst)

# Attributes
* obligatory
    * `catalyst_fastcgi.service_name` - name of your catalyst application, default is 'foo'
    * `catalyst_fastcgi.server_name` - name of virtual host server, default is 'foo.x'
    * `catalyst_fastcgi.application.user` - a user name that we should change to before starting application, default is 'foo'
    * `catalyst_fastcgi.application.group` - a group name that we should change to before starting application, default is 'foo'
    * `catalyst_fastcgi.application.home` - a dir where catalyst application resides, default is '/tmp/foo'
    * `catalyst_fastcgi.application.script` - a name of script to start applicationm, an absolute path to your application  will be constructed with application_home/script/application_script, default is 'foo_fastcgi.pl'
    * `catalyst_fastcgi.catalyst_config` - a path to catalyst config file, default is '/tmp/foo/foo.conf'
    * `catalyst_fastcgi.socket` - a socket, application will be binded to, default is '/tmp/foo.socket'
* optional
    * `catalyst_fastcgi.start_service` - true|false, whether to try to start application when configuring is done, default value `false`
    * `catalyst_fastcgi.application.perl5lib` - an array of perl5lib pathes, default is []
    * `catalyst_fastcgi.nproc` - Integer, a number of processes will be launched when application start in fastcgi mode, default is 2
    * `catalyst_fastcgi.envvars` - a hash of environment vars, passed to application environment, default is { :CATALYST_DEBUG => 1 }
    * `catalyst_fastcgi.proc_manager` - a perl class, implimenting Fast CGI Process ProcManager
* optional for ssl mode, see explanation in [apache cookbook](https://github.com/melezhik/cookbooks/tree/master/apache)
    * `ssl`, default value false
    * `ssl_cipher_suite`, default value nil
    * `ssl_certificate_file`, default value nil
    * `ssl_certificate_key_file`, default value nil
    

