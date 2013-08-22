# installs Pinto application in standalone mode - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod


class Chef::Recipe
  include PintoLibrary
end

pinto_home = pinto_home()
pinto_user_home = pinto_user_home()

log "pinto_user_home: #{pinto_user_home}"
log "pinto_home: #{pinto_home}"

node.pinto.packages.each do |p|
    package p
end

unless node.pinto.user == 'root'
    group node.pinto.group
    user node.pinto.user do
        gid node.pinto.group
        supports :manage_home => true
        home pinto_user_home
        shell node.pinto.user_shell
    end
end

create_pinto_sub_dirs()

case node.platform 

    when 'centos'
    # on centos we need install some missed modules explicitelly
    # see https://github.com/thaljef/Pinto/issues/67

    log "Downloading the standalone executable cpanminus client from #{node.pinto.cpanminus_url}"

    remote_file "#{pinto_home}/misc/bin/cpanm" do
        source node.pinto.cpanminus_url 
        user node.pinto.user
        group node.pinto.group
        mode '755'
    end

    execute "#{pinto_home}/misc/bin/cpanm --skip-satisfied --quiet Module::CoreList"

end


remote_file "#{pinto_home}/misc/bin/installer.sh" do
    source node.pinto.installer_url 
    user node.pinto.user
    group node.pinto.group
    mode '755'
end


execute "cat #{pinto_home}/misc/bin/installer.sh | bash" do
    user node.pinto.user
    group node.pinto.group
    environment( { 'HOME' => pinto_user_home  } )
end



