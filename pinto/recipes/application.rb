# installs pinto application - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod

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

log "Downloading the standalone executable cpanminus client from #{node.pinto.bootstrap.cpanminus_url}"


remote_file "#{node.pinto.bootstrap.home}/bin/cpanm" do
    source node.pinto.bootstrap.cpanminus_url 
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    mode '755'
end



# execute 'cpanm App::Pinto --sudo'

