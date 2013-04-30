class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates init script file' do
      file("/tmp/psgi/dancer").must_exist
    end
    # Example spec tests can be found at http://git.io/Fahwsw
    # it 'installs init script' { file("/tmp/psgi/dancer").must_exist }
    it 'add proper content into init script file' do
      file("/tmp/psgi/dancer").must_include 'APPLICATION_HOME=/home/user/app/MyApplication'
      file("/tmp/psgi/dancer").must_include 'DANCER_CONFDIR="${APPLICATION_HOME}"'
    end
  end
end
