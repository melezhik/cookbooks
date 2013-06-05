# installs Pinto application in standalone mode - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod


class Chef::Recipe
  include PintoLibrary
end

pinto_home = pinto_home()
pinto_user_home = pinto_user_home()

log "pinto_user_home: #{pinto_user_home}"
log "pinto_home: #{pinto_home}"

node.pinto.bootstrap.packages.each do |p|
    package p
end

unless node.pinto.bootstrap.user == 'root'
    group node.pinto.bootstrap.group
    user node.pinto.bootstrap.user do
        gid node.pinto.bootstrap.group
        supports :manage_home => true
        # home pinto_user_home
    end
end

create_pinto_sub_dirs()

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
            environment( { 'HOME' => pinto_user_home  } )
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
    environment( { 'HOME' => pinto_user_home  } )
end



