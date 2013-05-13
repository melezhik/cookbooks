# installs Pinto application in standalone mode - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod

node.pinto.bootstrap.packages.each do |p|
    package p
end

directory node.pinto.bootstrap.home do
    recursive true
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

directory "#{node.pinto.bootstrap.home}/bin" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

directory "#{node.pinto.bootstrap.home}/misc" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

directory "#{node.pinto.bootstrap.home}/misc/bin/" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

directory "#{node.pinto.bootstrap.home}/etc" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

remote_file "#{node.pinto.bootstrap.home}/misc/bin/installer.sh" do
    source node.pinto.bootstrap.installer_url 
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    mode '755'
end


execute "cat #{node.pinto.bootstrap.home}/misc/bin/installer.sh | bash" do
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end



