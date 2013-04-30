class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates init script file' do
      file("/tmp/psgi/bar").must_exist
    end
    # Example spec tests can be found at http://git.io/Fahwsw
    # it 'install init script' { file("/tmp/psgi/app").must_exist }
    it 'add proper content into init script file' do
      file("/tmp/psgi/bar").must_include 'CATALYST_CONFIG'
      file("/tmp/psgi/bar").must_include 'CATALYST_DEBUG=1'
      file("/tmp/psgi/bar").must_include 'SCRIPTNAME=/tmp/psgi/$NAME'
    end
  end
end
