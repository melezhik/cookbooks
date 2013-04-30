class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates init script file' do
      file("/tmp/psgi/foo").must_exist
    end
    # Example spec tests can be found at http://git.io/Fahwsw
    # it 'install init script' { file("/tmp/psgi/app").must_exist }
    it 'add proper content into init script file' do
      file("/tmp/psgi/foo").must_include 'APPLICATION_HOME=/home/user/app/MyApplication'
      file("/tmp/psgi/foo").must_include 'DANCER_CONFDIR="${APPLICATION_HOME}"'
    end
  end
end
