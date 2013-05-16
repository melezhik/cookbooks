cpan_client 'Bundler' do
    install_type 'cpan_module'
    user 'root'
    group 'root'
    action 'install'
end
cpan_client 'Bundler' do
    install_type 'cpan_module'
    user 'root'
    group 'root'
    version '0.0.29'
    action 'install'
end
