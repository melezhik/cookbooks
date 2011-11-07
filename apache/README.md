Description
===========
various apache server related resource provides (LWRP)

* `apache_fastcgi` - install fastcgi server via name based virtual host, now only `external` mode available
  
Requirements
============

* apache server
* mod_fastcgi

Resource Attributes
===================

* obligatory 
    * `socket` - a socket to which fast cgi external server is binded
    * `server_name` - name of virtual host 
* optional
    * `timeout` - Integer, a time to wait for fast cgi server response, in seconds, default value `180`
    * `access_log` - a path to apache access log file
    * `error_log` - a path to apache error log file
    
 
Usage
=====

    apache_fastcgi 'myserver' do 
     action 'install'
     socket '/var/run/fast-cgi-server/socket'
     server_name 'host.myserver.com'
    end


Links
=====

 * http://httpd.apache.org/docs/1.3/vhosts/
 * http://www.fastcgi.com/drupal/node/25

