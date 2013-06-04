default.pinto.bootstrap.user = 'pinto'
default.pinto.bootstrap.group = 'pinto'

default.pinto.bootstrap.installer_url = 'http://getpinto.stratopan.com'

default.pinto.bootstrap.home = "/home/pinto"

default.pinto.bootstrap.cpanminus_url = 'http://xrl.us/cpanm'

default.pinto.bootstrap.packages = %w[ curl ]


case platform 
    when 'centos'
        default.pinto.bootstrap.cpan.packages = %w[  ]
        default.pinto.bootstrap.packages <<  'zlib-devel'
        default.pinto.bootstrap.packages <<  'perl-devel' 
    when 'ubuntu'
        default.pinto.bootstrap.packages <<  'make'
        default.pinto.bootstrap.cpan.packages = []
    when 'debian'
        default.pinto.bootstrap.packages <<  'make'
        default.pinto.bootstrap.cpan.packages = []
end


default.pinto.server.repo_root = "/home/pinto/opt/local/pinto/repo"
default.pinto.server.host = '0.0.0.0'
default.pinto.server.port = '5000'
default.pinto.server.workers = '3'


# these are 'non-public'  attributes:

default.pinto.bootstrap.slow_tests = '0'


