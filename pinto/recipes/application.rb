# installs Pinto application - see https://metacpan.org/module/THALJEF/Pinto-0.082/lib/Pinto/Manual/Installing.pod#___pod
# this code is originated from https://raw.github.com/thaljef/Pinto/master/etc/install.sh

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

log "Downloading the standalone executable cpanminus client from #{node.pinto.bootstrap.cpanminus_url}"


remote_file "#{node.pinto.bootstrap.home}/misc/bin/cpanm" do
    source node.pinto.bootstrap.cpanminus_url 
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    mode '755'
end

log "Installing missed cpan packages into #{node.pinto.bootstrap.home}"

node.pinto.bootstrap.missed.cpan.packages.each do |p|
    execute "#{node.pinto.bootstrap.home}/misc/bin/cpanm --skip-satisfied --quiet --local-lib #{node.pinto.bootstrap.home} #{p}" do
        user node.pinto.bootstrap.user
        group node.pinto.bootstrap.group
    end
end

log "Installing pinto into #{node.pinto.bootstrap.home}"

execute "#{node.pinto.bootstrap.home}/misc/bin/cpanm --notest --quiet --mirror #{node.pinto.bootstrap.repo_url} --mirror-only --local-lib-contained #{node.pinto.bootstrap.home} --man-pages Pinto" do
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    environment( { 'PERL5LIB' =>  "#{node.pinto.bootstrap.home}/lib/perl5" } )
end

template "#{node.pinto.bootstrap.home}/etc/bashrc" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    source 'pinto_bashrc.erb'
    variables :home => node.pinto.bootstrap.home
    mode '644'
end

message = "
    pinto has been installed at #{node.pinto.bootstrap.home}.  
    To activate, give this command:

        source #{node.pinto.bootstrap.home}/etc/bashrc

    To make pinto part of your everyday environment, add that 
    command to your ~/.profile or ~/.bashrc file as well.  

    Thank you for installing pinto. I hope you find it useful.
    Send feedback to jeff@stratopan.com
"
log message 



