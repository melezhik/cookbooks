cpan_client 'Bundler' do
    install_type 'cpan_module'
    user 'root'
    group 'root'
    action 'install'
    install_base 'bar'
    cwd '/tmp/foo/'
end

