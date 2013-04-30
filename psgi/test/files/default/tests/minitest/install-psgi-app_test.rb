class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates init script file' do
      file("/tmp/psgi/app").must_exist
    end
    # Example spec tests can be found at http://git.io/Fahwsw
    # it 'installs init script' { file("/tmp/psgi/app").must_exist }
    it 'add proper content into init script file' do
      file("/tmp/psgi/app").must_include 'APPLICATION_USER=user'
      file("/tmp/psgi/app").must_include 'CATALYST_DEBUG'
    end
  end
end
