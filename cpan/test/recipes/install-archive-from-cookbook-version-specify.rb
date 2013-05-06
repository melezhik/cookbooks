cpan_client 'Bundler-v0.0.29.tar.gz' do
    from_cookbook 'cpan-test'
    version '=0.0.29'
    install_type 'cpan_module'
    user 'root'
    group 'root'
    action 'install'
end

