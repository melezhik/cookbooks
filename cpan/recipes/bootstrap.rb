include_recipe 'cpan'

node.cpan_client.bootstrap.packages.each  { |p| package p }

execute 'curl -L http://cpanmin.us | perl - --sudo App::cpanminus' do
    only_if do
        unless node.cpan_client.bootstrap.keep_uptodate
            if system("which cpanm > /dev/null 2>&1")
                return false
            end
        end
        return true
    end
end

node.cpan_client.bootstrap.cpan_packages.each  do |m|
    skip_satisfied = unless node.cpan_client.bootstrap.keep_uptodate
        '--skip-satisfied '
    else
        ''
    end
    execute "cpanm #{skip_satisfied}#{m}" do
        user 'root'
        group 'root'
    end
end

