class PintoSpec < MiniTest::Chef::Spec

    describe 'installs pinto' do

        it 'creates pinto user/group' do
            group("#{node[:pinto][:bootstrap][:group]}").must_exist
            user("#{node[:pinto][:bootstrap][:user]}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:user]}")
        end

        it 'creates pinto user home directory' do
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            directory("#{node[:pinto][:bootstrap][:home]}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
        end

        it 'creates pinto installation base directory' do
            directory("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            directory("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
        end

        %w( pinto pintod ).each do |file|
            it "installs #{file} into pinto installation base directory" do
                file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/bin/#{file}").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
                file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/bin/#{file}").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
                file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/bin/#{file}").must_have(:mode, "555")
            end
        end

        it "installs pinto bashrc file" do
            file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc").must_have(:mode, "644")
            file("#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc").must_include(node[:pinto][:bootstrap][:home])
        end

        it "installs valid pinto bashrc file" do

            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc'"

            %w( pinto pintod ).each do |file|
                result = assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc && which #{file}'"
                assert_includes result, "#{node[:pinto][:bootstrap][:home]}/opt/local/pinto/bin/#{file}"
            end

            result = assert_sh("sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc && pinto version'")
            %w( App::Pinto Pinto Pinto::Remote ).each do |l|
                assert_includes result, l
            end
        end


        it "smoke tests on installed pinto client" do
            assert_sh "rm -rf #{node[:pinto][:bootstrap][:home]}/opt/local/tmp/"
            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'mkdir  #{node[:pinto][:bootstrap][:home]}/opt/local/tmp/'"
            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc && pinto -r #{node[:pinto][:bootstrap][:home]}/opt/local/tmp/ init'"
            assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc && pinto -r #{node[:pinto][:bootstrap][:home]}/opt/local/tmp/ pull Bundler'"

            if node[:pinto][:bootstrap][:slow_tests] == 1
                        result = assert_sh "sudo -u #{node[:pinto][:bootstrap][:user]} bash -c 'source #{node[:pinto][:bootstrap][:home]}/opt/local/pinto/etc/bashrc && pinto -r #{node[:pinto][:bootstrap][:home]}/opt/local/tmp/ list'"
                        assert_includes result, '[rf-] Bundler'
            else
                    puts "skip slow smoke tests"    
            end

        end

    end    
end

