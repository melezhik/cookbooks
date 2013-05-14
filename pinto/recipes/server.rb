template '/etc/init.d/pintod' do
    owner 'root'
    group 'root'
    source 'init.erb'
    variables({ 
        :home => node.pinto.bootstrap.home,
        :workers => node.pinto.server.workers,
        :host => node.pinto.server.host,
        :port => node.pinto.server.port,
        :user => node.pinto.bootstrap.user,
        :group => node.pinto.bootstrap.group,
        :repo_root => node.pinto.server.repo_root
    })
    mode '755'
    notifies :restart, "service[pintod]", :delayed
end


log 'init pinto repo'

execute "bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc; pinto -r #{node.pinto.server.repo_root} init'" do
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

