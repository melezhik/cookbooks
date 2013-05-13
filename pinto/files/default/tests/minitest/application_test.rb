class PintoSpec < MiniTest::Chef::Spec

    describe 'installs pinto' do

        it 'creates pinto home directory' do
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
        end

        %w( pinto pintod ).each do |file|
            it "installs #{file} into pinto home" do
                file("#{node[:pinto][:bootstrap][:home]}/bin/#{file}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
                file("#{node[:pinto][:bootstrap][:home]}/bin/#{file}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
                file("#{node[:pinto][:bootstrap][:home]}/bin/#{file}").must_have(:mode, "555")
            end
        end

        it "installs pinto bashrc file" do
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_have(:mode, "644")
            file("#{node[:pinto][:bootstrap][:home]}/etc/bashrc").must_include(node[:pinto][:bootstrap][:home])
        end

        it "installs valid pinto bashrc file" do

            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/etc/bashrc'"

            %w( pinto pintod ).each do |file|
                result = assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/etc/bashrc && which #{file}'"
                assert_includes result, "#{node[:pinto][:bootstrap][:home]}/bin/#{file}"
            end

            result = assert_sh("sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/etc/bashrc && pinto version'")
            %w( App::Pinto Pinto Pinto::Remote ).each do |l|
                assert_includes result, l
            end
        end


        it "smoke tests on installed pinto client" do
            assert_sh 'rm -rf /tmp/pinto-smoke-repo'
            assert_sh "mkdir  /tmp/pinto-smoke-repo"
            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/etc/bashrc && pinto -r /tmp/pinto-smoke-repo init'"
            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/etc/bashrc && pinto -r /tmp/pinto-smoke-repo pull Bundler'"
            if node[:pinto][:bootstrap][:slow_tests] == 1
                result = assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/etc/bashrc && pinto -r /tmp/pinto-smoke-repo list'"
                assert_includes result, '[rf-] Bundler'
            end
        end

    end    
end

