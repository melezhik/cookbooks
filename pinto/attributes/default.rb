default.pinto.bootstrap.packages = %w[ curl ]

case platform 
    when 'centos'
        default.pinto.bootstrap.packages << 'perl-devel'
end
