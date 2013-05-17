class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file("/tmp/psgi/default/app").must_exist
      file("/tmp/psgi/default/app").must_include 'DAEMON_ARGS="-s FCGI $PROCMANAGER_OPT --listen /tmp/app_fcgi.socket -E development $PROCTITLE_OPT $NPROC_OPT "'
      file("/tmp/psgi/default/app").must_include 'SCRIPTNAME=/tmp/psgi/default/$NAME'
    end
  end
end
