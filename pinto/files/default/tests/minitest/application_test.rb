class PintoSpec < MiniTest::Chef::Spec

    describe 'installs pinto' do

        it 'creates pinto home directory' do
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
        end

        it "installs cpanminus client into pinto home" do
            file("#{node[:pinto][:bootstrap][:home]}/bin/cpanm").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/cpanm").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/cpanm").must_have(:mode, "755")
            result = assert_sh("cd #{node[:pinto][:bootstrap][:home]}/bin && ./cpanm --version")
            assert_includes result, 'App::cpanminus'
        end

        it "installs pinto client into pinto home" do
            file("#{node[:pinto][:bootstrap][:home]}/bin/pinto").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/pinto").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/pinto").must_have(:mode, "755")
            result = assert_sh("export PERL5LIB=$PERL5LIB:#{node[:pinto][:bootstrap][:home]}/lib/perl5 && cd #{node[:pinto][:bootstrap][:home]}/bin/pinto version")
            %w( App::Pinto Pinto Pinto::Remote).each do |l|
                assert_includes result, l
            end
        end

        it "installs pinto bashrc file" do
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_have(:mode, "644")
        end


    end    

end
