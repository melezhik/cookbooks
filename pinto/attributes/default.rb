default.pinto.bootstrap.user = 'root'
default.pinto.bootstrap.group = 'root'

default.pinto.bootstrap.repo_url = 'http://stratopan.com:2700/Stratopan/Pinto/Production'

default.pinto.bootstrap.home = "#{ENV['HOME']}/opt/local/pinto"


default.pinto.bootstrap.cpanminus_url = 'http://xrl.us/cpanm'

default.pinto.bootstrap.packages = %w[ ]
default.pinto.bootstrap.cpan.packages = %w[ ]

case platform 
    when 'centos'
        default.pinto.bootstrap.packages <<  'zlib-devel'
        default.pinto.bootstrap.packages <<  'perl-devel' 
        default.pinto.bootstrap.cpan.packages << 'Module::CoreList'    
end


# these are 'non-public'  attributes:

default.pinto.bootstrap.slow_tests = '0'


