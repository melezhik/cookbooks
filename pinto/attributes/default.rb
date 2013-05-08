default.pinto.bootstrap.user = 'root'
default.pinto.bootstrap.group = 'root'

default.pinto.bootstrap.repo_url = 'http://stratopan.com:2700/Stratopan/Pinto/Production'

default.pinto.bootstrap.home = "#{ENV['HOME']}/opt/local/pinto"


default.pinto.bootstrap.cpanminus_url = 'http://xrl.us/cpanm'

default.pinto.bootstrap.packages = %w[ ]
default.pinto.bootstrap.missed.cpan.packages = %w[ Time::HiRes CGI Module::CoreList ]

case platform 
    when 'centos'
        default.pinto.bootstrap.packages <<  'zlib-devel'
        default.pinto.bootstrap.packages <<  'perl-devel' 
    when 'ubuntu'
        default.pinto.bootstrap.packages <<  'make'
    when 'debian'
        default.pinto.bootstrap.packages <<  'make'

end


default.pinto.server.repo_root = "/tmp/"

# these are 'non-public'  attributes:

default.pinto.bootstrap.slow_tests = '0'


