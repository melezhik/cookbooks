0.0.8
===
- new parameter - `error_page`
- `static` may be an Array

0.0.7
===
now nginx site config mode is `0664`

0.0.6
===
now `ssl;` is appended for ssl enabled ips according to http://nginx.org/ru/docs/http/ngx_http_core_module.html#listen

0.0.5
===
- changes in interface: 
   - new parameters:
     - `fastcgi_param`
     - `root`
   - removed parameters:
     - `:expire`
   - modified parameters:
       - `static` is not array now and not in servers list
   
0.0.4
===
- now one may set alternative location for fastcgi application, default one is '/'

0.0.3
===
- handling empty ips

0.0.2
===
- bug fix for 'fastcgi_param  HTTPS on;' in template
