class PsgiSpec < MiniTest::Chef::Spec

  describe 'installs and runs psgi application as fcgi server' do
    it 'creates init script file' do
      file("/etc/init.d/app").must_exist
    end

    it 'creates init script file with proper owner' do
      file("/etc/init.d/app").must_have(:owner,"root")
    end

    it 'creates init script file with proper group' do
      file("/etc/init.d/app").must_have(:group,"root")
    end

    it 'creates init script file with proper mode' do
      file("/etc/init.d/app").must_have(:mode,"755")
    end

    it 'init script returns successfull status' do
      result = assert_sh('sudo /etc/init.d/app status')
      assert_includes result, 'running'
    end

    it 'CGI script returns 200 OK and Hello World' do
      result = assert_sh("sudo bash -c 'cd /tmp/psgi/app && SERVER_PORT=80 SERVER_NAME=127.0.0.1 SCRIPT_NAME=/ REQUEST_METHOD=GET plackup -s CGI app.psgi'")
      assert_includes result, 'Status: 200'
      assert_includes result, 'Hello World'
    end

    it 'runs fcgi server' do

      service("app").must_be_running
      
      result = assert_sh('ps axu | grep perl-fcgi | grep -v grep | wc -l')
      assert_includes result, '2'

      result = assert_sh("ps axu | grep app | grep -v grep | awk '{print $1}'")
      assert_includes result, 'app'

      assert_sh("stat /tmp/app_fcgi.socket")

    end

    it 'multiple start should not increase number of child process'do
      (1..3).each do |i|
        assert('/etc/init.d/app start')
      end
      result = assert_sh('ps axu | grep perl-fcgi | grep -v grep | wc -l')
      assert_includes result, '2'
    end

    it 'nginx site returns Hello World' do
      result = assert_sh("curl 127.0.0.1:8888")
      assert_includes result, 'Hello World'
    end

  end
end
