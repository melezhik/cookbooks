class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file("/tmp/psgi/default/app").must_exist
      file("/tmp/psgi/default/app").must_include 'CATALYST_CONFIG'
      file("/tmp/psgi/default/app").must_include 'CATALYST_DEBUG=1'
      file("/tmp/psgi/default/app").must_include 'SCRIPTNAME=/tmp/psgi/default/$NAME'
    end
  end
end
