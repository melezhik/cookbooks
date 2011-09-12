include_recipe 'cpan'


upgrade_command = 'rm -rf /tmp/cpan-client-download/ && cd /tmp/cpan-client-download/ '
upgrade_command << " wget @{node.cpan_client.download_url} && tar -zxf *.tar.gz "
upgrade_command << ' perl Makefile.PL && make && make test && make install'

execute 'upgrade cpan client to proper version' do
    command upgrade_command
    not_if "perl -e 'use CPAN #{node.cpan_client.minimal_version}'"
end

node.cpan_client.bootstrap.deps.each  do |m|
 cpan_client m[:module] do
  user 'root'
  group 'root'
  install_type 'cpan_module'
  version m[:version]
  action 'install'
  install_base node.cpan_client.bootstrap.install_base
 end
end

