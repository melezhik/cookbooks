template "#{node.pinto.bootstrap.home}/bin/pintod.psgi" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    source 'pintod.psgi.erb'
    variables :repo_root => node.pinto.server.repo_root
    mode '755'
end

template "#{node.pinto.bootstrap.home}/bin/pintod.sh" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    source 'pintod.sh.erb'
    variables :home => node.pinto.bootstrap.home
    mode '755'
end

template '/etc/init.d/pintod' do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    source 'init.erb'
    variables :home => node.pinto.bootstrap.home, :user => node.pinto.bootstrap.user
    mode '755'
end

