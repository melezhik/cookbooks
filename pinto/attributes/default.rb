default.pinto.user = 'pinto'
default.pinto.group = 'pinto'

default.pinto.installer_url = 'http://getpinto.stratopan.com'

default.pinto.cpanminus_url = 'http://xrl.us/cpanm'

default.pinto.packages = %w[ curl ]


case platform 
    when 'centos'
        default.pinto.cpan.packages = %w[  ]
        default.pinto.packages <<  'zlib-devel'
        default.pinto.packages <<  'perl-devel' 
    when 'ubuntu'
        default.pinto.packages <<  'make'
        default.pinto.cpan.packages = []
    when 'debian'
        default.pinto.packages <<  'make'
        default.pinto.cpan.packages = []
end


default.pinto.server.host = '0.0.0.0'
default.pinto.server.port = '5000'
default.pinto.server.workers = '3'


# these are 'non-public'  attributes:

default.pinto.slow_tests = '0'


