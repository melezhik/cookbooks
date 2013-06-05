class Chef::Recipe
  include PintoLibrary
end

pinto_home = pinto_home()
repo_root = repo_root()

log "pinto_home: #{pinto_home}"
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
        :user => node.pinto.user,
        :group => node.pinto.group,
        :repo_root => repo_root
    })
    mode '755'
    notifies :restart, "service[pintod]", :delayed
end


log 'init pinto repo'

execute "bash -c 'source #{pinto_home}/etc/bashrc; pinto -r #{repo_root} init'" do
    user node[:pinto][:user]
    group node[:pinto][:group]
    not_if { ::File.exists? repo_root } 
    notifies :restart, "service[pintod]", :delayed
end

service 'pintod' do
    action :start
end


service 'pintod' do
    action :enable
end

