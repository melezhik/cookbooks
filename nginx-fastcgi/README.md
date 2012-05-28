Description
===
Create nginx site to run your fastcgi application under nginx front-end

Requirements
===
Should work on any platform where nginx is installed. Tested on Ubuntu.

Limitations
===
fastcgi standalone server mode is only supported

DEFINITIONS
===
``nginx_fastcgi``

This definition can be used to create nginx site to run your fastcgi application under nginx front-end.
 
The definition takes the following params:
 
* name: specifies a single path (string) where nginx site config will be installed. No default, this must be specified.
* socket: specifies the port or socket on which the FastCGI-server is listening, see http://wiki.nginx.org/HttpFastcgiModule#fastcgi_pass
* static: specifies location of static files (not handled by application, but nginx)
* servers: specifies all virtual hosts to be included into site config
* cookbook: select the template source from the specified cookbook. By default it will use the cookbook where the definition is used.

See USAGE below.

Usage
===

To install nginx site config for http virtual host 127.0.0.1:80 with hostname foo.site.x:
    
    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        servers [
            {
                :ip => '127.0.0.1',
                :server_name => 'foo.site.x'
            }
        ]
    end


To install nginx site config for https virtual host with hostname bar.site.x:
    
    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        servers [
            {
                :server_name => 'bar.site.x',
                :ssl => true,
                :ssl_include_path => 'nginx_ssl_settings.conf'
                
            }
        ]
    end

To install nginx site config with static files handle by nginx:

    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        root  '/var/www/MyApp/root'
        socket '/tmp/application.socket'
        servers [
            {
                :server_name => 'foo.site.x',
            }
        ]
    end

To install nginx site config for http/https virtual hosts with hostname bar.site.x, with all http traffic get redirected to https host:
    
    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        servers [
            {
                :ip => '127.0.0.1',
                :server_name => 'bar.site.x',
                :redirect => 'https'                
            },
            {
                :ip => '127.0.0.1',
                :server_name => 'bar.site.x',
                :ssl => true,
                :ssl_include_path => 'nginx_ssl_settings.conf'
            }
        ]
    end

To install nginx site config with static files handle by nginx:

    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        static(
                :location => 'static/',
                :root => '/var/www/MyApp/root'
        )
        servers [
            {
                :server_name => 'foo.site.x',
            }
        ]
    end

Features
===

For complete examples of usage see cucumber features in features/ dir

