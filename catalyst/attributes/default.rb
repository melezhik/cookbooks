case platform
when 'gentoo'
    set[:catalyst][:initscript][:template][:dir] = '/etc/conf.d'
when 'ubuntu', 'debian'
    set[:catalyst][:initscript][:template][:dir] = '/etc/init.d'
end


case platform
when 'gentoo'
    set[:catalyst][:initscript][:template][:mode] = '0664'
when 'ubuntu', 'debian'
    set[:catalyst][:initscript][:template][:mode] = '0755'
end
