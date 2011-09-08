include_recipe 'local_lib'

node.local_lib.bootstrap.deps.each  do |m|
 local_lib_install m[:module] do
  user 'root'
  group 'root'
  install_type 'cpan_module'
  version m[:version]
  action 'install'
  install_base node.local_lib.bootstrap.install_base
 end
end

