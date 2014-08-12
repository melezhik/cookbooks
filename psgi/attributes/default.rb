default[:psgi][:plack][:version] = '1.0024'


case platform 
    when 'centos'
        default[:psgi][:install][:dir] = '/etc/init/'
        default[:psgi][:install][:extention] = '.conf'
        default[:psgi][:service][:provider] = Chef::Provider::Service::Upstart
    when 'ubuntu'
        default[:psgi][:install][:dir] = '/etc/init/'
        default[:psgi][:install][:extention] = '.conf'
        default[:psgi][:service][:provider] = Chef::Provider::Service::Upstart
    when 'debian'
        default[:psgi][:install][:dir] = '/etc/init.d/'
        default[:psgi][:install][:extention] = nil
        default[:psgi][:service][:provider] = Chef::Provider::Service::Debian
end

