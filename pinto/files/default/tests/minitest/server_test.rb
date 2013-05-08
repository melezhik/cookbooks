class PintoSpec < MiniTest::Chef::Spec

    describe 'installs pintod server' do

        it 'creates pintod init script' do
            file('/etc/init.d/pintod').must_exist.with(:owner, 'root')
            file('/etc/init.d/pintod').must_exist.with(:group, 'root')
            file('/etc/init.d/pintod').must_have(:mode, "755")
        end

        it 'creates pintod launcher script' do
            file("#{node[:pinto][:bootstrap][:home]}/bin/pintod.sh").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/pintod.sh").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/pintod.sh").must_have(:mode, "755")
        end

        it 'creates pintod.psgi script' do
            file("#{node[:pinto][:bootstrap][:home]}/bin/pintod.psgi").must_exist.with(:owner, "#{node[:pinto][:bootstrap][:user]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/pintod.psgi").must_exist.with(:group, "#{node[:pinto][:bootstrap][:group]}")
            file("#{node[:pinto][:bootstrap][:home]}/bin/pintod.psgi").must_have(:mode, "755")
        end

    end    
end

