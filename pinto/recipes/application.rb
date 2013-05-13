# installs Pinto application in standalone mode - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod

node.pinto.bootstrap.packages.each do |p|
    package p
end

group node.pinto.bootstrap.group

user node.pinto.bootstrap.user do
    gid node.pinto.bootstrap.group
    supports :manage_home => true
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

directory "#{node.pinto.bootstrap.home}/opt/local/pinto" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    recursive true
end

case node.platform 

    when 'centos'
    # on centos we need install some missed modules explicitelly
    # see https://github.com/thaljef/Pinto/issues/67

    log "Downloading the standalone executable cpanminus client from #{node.pinto.bootstrap.cpanminus_url}"
 
    remote_file "#{node.pinto.bootstrap.home}/misc/bin/cpanm" do
        source node.pinto.bootstrap.cpanminus_url 
        user node.pinto.bootstrap.user
        group node.pinto.bootstrap.group
        mode '755'
    end
     
    log "Installing missed cpan packages into #{node.pinto.bootstrap.home}"
     
    node.pinto.bootstrap.cpan.packages.each do |p|
        execute "#{node.pinto.bootstrap.home}/misc/bin/cpanm --skip-satisfied --quiet --local-lib #{node.pinto.bootstrap.home}/opt/local/pinto #{p}" do
            user node.pinto.bootstrap.user
            group node.pinto.bootstrap.group
            environment( { 'HOME' => node.pinto.bootstrap.home } )
        end
    end


    execute "#{node.pinto.bootstrap.home}/misc/bin/cpanm --skip-satisfied --quiet Module::CoreList" do


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
    environment( { 'HOME' => node.pinto.bootstrap.home  } )
end



