default.cpanminus.bootstrap.packages = %w[ curl ]

case platform 
    when 'centos'
        default.cpanminus.bootstrap.packages << 'perl-devel'
end

