class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file("/tmp/psgi/catalyst/app").must_exist
      file("/tmp/psgi/catalyst/app").must_include 'APPLICATION_USER=app'
      file("/tmp/psgi/catalyst/app").must_include 'CATALYST_DEBUG=1'
      file("/tmp/psgi/catalyst/app").must_include 'SCRIPTNAME=/tmp/psgi/catalyst/$NAME'
      file("/tmp/psgi/catalyst/app").must_include 'APPLICATION_USER=app'
      file("/tmp/psgi/catalyst/app").must_include 'NAME="app"'
      file("/tmp/psgi/catalyst/app").must_include 'CATALYST_CONFIG=/home/user/app/MyApplication/app.conf'
      file("/tmp/psgi/catalyst/app").must_include 'deployment'
    end
  end
end
