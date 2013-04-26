cpan_module 'Plack' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
end


cpan_module 'FCGI' do
  install_type 'cpan_module'
  user 'root'
  group 'root'
  action :install
end

package 'nginx'
