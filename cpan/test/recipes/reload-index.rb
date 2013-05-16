cpan_client 'index reload' do
    install_type 'cpan_module'
    user 'root'
    group 'root'
    action 'reload_cpan_index'
end

