# installs Pinto application in standalone mode - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod

node.pinto.bootstrap.packages.each do |p|
    package p
end

if node.pinto.bootstrap.user == 'root'
    pinto_home = '/opt/local/pinto'
else
    group node.pinto.bootstrap.group
    user node.pinto.bootstrap.user do
        gid node.pinto.bootstrap.group
        supports :manage_home => true
        home pinto_home
    end
    pinto_home = "/home/#{node.pinto.bootstrap.user}/opt/local/pinto"
end

log "pinto_home: #{pinto_home}"

directory pinto_home do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    recursive true
end

directory "#{pinto_home}/bin" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

directory "#{pinto_home}/misc" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end

directory "#{pinto_home}/misc/bin/" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end


case node.platform 

    when 'centos'
    # on centos we need install some missed modules explicitelly
    # see https://github.com/thaljef/Pinto/issues/67

    log "Downloading the standalone executable cpanminus client from #{node.pinto.bootstrap.cpanminus_url}"
 
    remote_file "#{pinto_home}/misc/bin/cpanm" do
        source node.pinto.bootstrap.cpanminus_url 
        user node.pinto.bootstrap.user
        group node.pinto.bootstrap.group
        mode '755'
    end
     
    log "Installing missed cpan packages into #{pinto_home}"
     
    node.pinto.bootstrap.cpan.packages.each do |p|
        execute "#{pinto_home}/misc/bin/cpanm --skip-satisfied --quiet --local-lib #{pinto_home} #{p}" do
            user node.pinto.bootstrap.user
            group node.pinto.bootstrap.group
            environment( { 'HOME' => ( node.pinto.bootstrap.user == 'root' ? nil : "/home/#{node.pinto.bootstrap.user}/" )  } )
        end
    end

    execute "#{pinto_home}/misc/bin/cpanm --skip-satisfied --quiet Module::CoreList"

end


remote_file "#{pinto_home}/misc/bin/installer.sh" do
    source node.pinto.bootstrap.installer_url 
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    mode '755'
end


execute "cat #{pinto_home}/misc/bin/installer.sh | bash" do
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    environment( { 'HOME' => ( node.pinto.bootstrap.user == 'root' ? nil : "/home/#{node.pinto.bootstrap.user}/" )  } )
end



