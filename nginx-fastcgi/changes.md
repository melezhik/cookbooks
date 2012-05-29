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
