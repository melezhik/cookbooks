class PintoSpec < MiniTest::Chef::Spec

    describe 'installs Pinto' do

        it 'creates Pinto home directory' do
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
        end

        it 'installs cpanminus client into Pinto home directory' do
            file("#{node[:pinto][:bootstrap][:home]}/bin/cpanm").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/cpanm").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/cpanm").must_have(:mode, "755")
            result = assert_sh("cd #{node[:pinto][:bootstrap][:home]}/bin && ./cpanm --version")
            assert_includes result, 'App::cpanminus'
        end

        it 'installs Pinto client' do
            result = assert_sh('pinto version')
            %w( App::Pinto Pinto Pinto::Remote).each do |l|
                assert_includes result, l
            end
        end
    end    

end
