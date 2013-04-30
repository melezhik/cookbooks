class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates init script file' do
      file("/etc/init.d/test").must_exist
    end

    it 'creates init script file with proper owner' do
      file("/etc/init.d/test").must_have(:owner,"root")
    end

    it 'creates init script file with proper group' do
      file("/etc/init.d/test").must_have(:group,"root")
    end

    it 'creates init script file with proper mode' do
      file("/etc/init.d/test").must_have(:mode,"755")
    end
  end
end
