# Description
Creates nginx site to run your fastcgi application with nginx front-end

# Requirements
Should work on any platform where nginx is installed. Tested on Ubuntu/Debian.

# Limitations
fastcgi standalone server mode is only supported

# DEFINITIONS
``nginx_fastcgi``

This definition can be used to create nginx site to run your fastcgi application with nginx front-end.
 
The definition takes the following parameters:
 
* `name`: specifies a path for nginx site configuration file. No default, this must be specified.
* `socket`: specifies unix/inet socket of FastCGI server. No default, this must be specified. Check out http://wiki.nginx.org/HttpFastcgiModule#fastcgi_pass for details.
* `static`: specifies location of static files (to be handled by nginx). Array of Hashes or hash with following keys:
   * `location`
   * `root`
* `servers`: specifies virtual hosts to be included into ngix site configuration. Array of Hashes with following keys:
   * `ip`
   * `server_name`
   * `ssl`
   * `ssl_include_path`
   * `error_page`
   * `redirect`
* `cookbook`: specifies the cookbook with nginx site configuration template. Optional
* `fastcgi_param`: specifies additional fastcgi params
* `error_page` - specifies custom error pages. Array of Hashes with following keys:
 * code
 * handler
Check out http://wiki.nginx.org/HttpCoreModule#error_page for details
* `fastcgi_intercept_errors` - specify value for fastcgi_intercept_errors. Check out http://wiki.nginx.org/HttpFastcgiModule#fastcgi_intercept_errors for details. Default value is false
* `fastcgi_read_timeout` - specify value for fastcgi read timeout. Check out http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_read_timeout for details. Default value is nil.

# Usage cases

## named virtual host, port 80

    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        servers [
            {
                :ip => '127.0.0.1',
                :server_name => 'foo.site.x'
            }
        ]
    end

## ssl enabled virtual host
    
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

## set document root

    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        root  '/var/www/MyApp/root'
        socket '/tmp/application.socket'
        servers [
            {
                :server_name => 'foo.site.x',
            }
        ]
    end

## enabling http -> https redirect

 # all http traffic get redirected to https host:
    
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

## handling static files by nginx

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

## set specific fastcgi params:

    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        fastcgi_param  [
            { :name => 'SCRIPT_NAME', :value => "\"\"" },
            { :name => 'PATH_INFO' , :value => '$uri' }
        ]
        servers [
            {
                :server_name => 'foo.site.x',
            }
        ]
    end

## set error page, code 500

    nginx_fastcgi '/etc/nginx/sites-available/foo.site.conf' do
        socket '/tmp/application.socket'
        servers [
            {
                :server_name => 'foo.site.x'
            }
        ]
        error_page [
            {
                :code       => 500,
                :handler    => '/500.html'
            }
        ]
    end
---

For complete examples of usage see https://github.com/melezhik/cookbooks/tree/master/nginx-fastcgi/features


