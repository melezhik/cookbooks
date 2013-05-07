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

directory "#{node.pinto.bootstrap.home}/etc" do
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


log "Installing pinto into #{node.pinto.bootstrap.home}"

execute "#{node.pinto.bootstrap.home}/bin/cpanm --notest --quiet --mirror #{node.pinto.bootstrap.repo_url} --mirror-only --local-lib-contained #{node.pinto.bootstrap.home} --man-pages Pinto" do
    user node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
end


log "Remove scripts and man pages that aren't from pinto"

execute "(cd #{node.pinto.bootstrap.home}/bin;      ls | grep -iv pinto | xargs rm -f)"
execute "(cd #{node.pinto.bootstrap.home}/man/man1; ls | grep -iv pinto | xargs rm -f)"
execute "(cd #{node.pinto.bootstrap.home}/man/man3; ls | grep -iv pinto | xargs rm -f)"


template "#{node.pinto.bootstrap.home}/etc/bashrc" do
    owner node.pinto.bootstrap.user
    group node.pinto.bootstrap.group
    source 'pinto_bashrc.erb'
    variables :home => node.pinto.bootstrap.home
end

# execute 'cpanm App::Pinto --sudo'

