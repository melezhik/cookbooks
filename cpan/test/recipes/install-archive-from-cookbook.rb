cpan_client 'Bundler-v0.0.30.tar.gz' do
    from_cookbook 'cpan-test'
    install_type 'cpan_module'
    user 'root'
    group 'root'
    action 'install'
end

