default.pinto.bootstrap.packages = %w[ ]

case platform 
    when 'centos'
        default.pinto.bootstrap.packages << 'zlib-devel'
end
