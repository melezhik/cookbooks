default.catalyst_fastcgi.service_name 'foo'
default.catalyst_fastcgi.server_name 'foo.x'

default.catalyst_fastcgi.application.user = 'foo'
default.catalyst_fastcgi.application.group = 'foo'
default.catalyst_fastcgi.application.home = '/tmp/foo'
default.catalyst_fastcgi.application.script = 'foo_fastcgi.pl'
default.catalyst_fastcgi.application.perl5lib = []

default.catalyst_fastcgi.catalyst_config = '/tmp/foo/foo.conf'
default.catalyst_fastcgi.socket = '/tmp/foo.socket'
default.catalyst_fastcgi.envvars  = { :CATALYST_DEBUG => 1 } 
default.catalyst_fastcgi.nproc  = 2
default.catalyst_fastcgi.proc_manager = 'Adriver::FCGI::ProcManager'

default.catalyst_fastcgi.start_service = false

default.catalyst_fastcgi.ssl = false
default.catalyst_fastcgi.ssl_cipher_suite = nil 
default.catalyst_fastcgi.ssl_certificate_file = nil 
default.catalyst_fastcgi.ssl_certificate_key_file = nil


