if node.pinto.bootstrap.user == 'root'
    pinto_home = '/opt/local/pinto'
    repo_root = '/opt/local/pinto/var/'
else
    pinto_home = "/home/#{node.pinto.bootstrap.user}/opt/local/pinto"
    repo_root = "/home/#{node.pinto.bootstrap.user}/opt/local/var"
end

log "repo_root: #{repo_root}"

template '/etc/init.d/pintod' do
    owner 'root'
    group 'root'
    source 'init.erb'
    variables({ 
        :home => pinto_home,
        :workers => node.pinto.server.workers,
        :host => node.pinto.server.host,
        :port => node.pinto.server.port,
        :user => node.pinto.bootstrap.user,
        :group => node.pinto.bootstrap.group,
        :repo_root => repo_root
    })
    mode '755'
    notifies :restart, "service[pintod]", :delayed
end


log 'init pinto repo'

execute "bash -c 'source #{pinto_home}/etc/bashrc; pinto -r #{repo_root} init'" do
    user node[:pinto][:bootstrap][:user]
    group node[:pinto][:bootstrap][:group]
    not_if { ::File.exists? node.pinto.server.repo_root } 
    notifies :restart, "service[pintod]", :delayed
end

service 'pintod' do
    action :start
end


service 'pintod' do
    action :enable
end

