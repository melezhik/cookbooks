include_recipe 'cpan::bootstrap'

cpan_client 'Plack' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
end

cpan_client 'FCGI' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
end

execute 'cpan --mirror http://cpan.webdev.x/CPAN --sudo Adriver::FCGI::ProcManager'

