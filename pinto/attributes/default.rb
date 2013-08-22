default.pinto.user = 'pinto'
default.pinto.group = 'pinto'
default.pinto.user_shell = '/bin/bash'

default.pinto.installer_url = 'http://getpinto.stratopan.com'

default.pinto.cpanminus_url = 'http://xrl.us/cpanm'

default.pinto.packages = %w[ curl ]

case platform 
    when 'centos'
        default.pinto.packages <<  'zlib-devel'
        default.pinto.packages <<  'perl-devel' 
    when 'ubuntu'
        default.pinto.packages <<  'make'
    when 'debian'
        default.pinto.packages <<  'make'
end


default.pinto.server.host = '0.0.0.0'
default.pinto.server.port = '3111'
default.pinto.server.workers = '3'


# these are 'non-public'  attributes:

default.pinto.slow_tests = '0'# is used in mini tests only
default.pinto.version = '0.087' # is used in mini tests only 

