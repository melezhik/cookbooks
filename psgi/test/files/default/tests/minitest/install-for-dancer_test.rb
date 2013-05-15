class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file("/tmp/psgi/dancer/app").must_exist
      file("/tmp/psgi/dancer/app").must_include 'APPLICATION_HOME=/home/user/app/MyApplication'
      file("/tmp/psgi/dancer/app").must_include 'DANCER_CONFDIR="${APPLICATION_HOME}"'
    end
  end
end
