class PsgiSpec < MiniTest::Chef::Spec

  describe 'installs and runs psgi application as starman server' do

    it 'creates init script file' do
      file("/etc/init.d/starman-psgi").must_exist
      file("/etc/init.d/starman-psgi").must_have(:owner,"root")
      file("/etc/init.d/starman-psgi").must_have(:group,"root")
      file("/etc/init.d/starman-psgi").must_have(:mode,"755")
    end

    it 'init script returns successfull status' do
      result = assert_sh('sudo /etc/init.d/starman-psgi status')
      assert_includes result, 'running'
    end

    it 'CGI script returns 200 OK and Hello World' do
      result = assert_sh("sudo bash -c 'cd /tmp/psgi/starman && SERVER_PORT=80 SERVER_NAME=127.0.0.1 SCRIPT_NAME=/ REQUEST_METHOD=GET plackup -s CGI app.psgi'")
      assert_includes result, 'Status: 200'
      assert_includes result, 'Hello World'
    end

    it 'runs starman server' do

      service("starman").must_be_running
      
      result = assert_sh('ps axu | grep starman | grep worker | grep -v grep | wc -l')
      assert_includes result, '2'

      result = assert_sh("ps axu | grep starman | grep -v grep | awk '{print $1}'")
      assert_includes result, 'app'

    end

    it 'multiple start should not increase number of child process'do
      (1..3).each do |i|
        assert('/etc/init.d/starman-psgi start')
      end
      result = assert_sh('ps axu | grep starman | grep worker | grep -v grep | wc -l')
      assert_includes result, '2'
    end

    it 'nginx site returns Hello World' do
      result = assert_sh("curl 127.0.0.1:5000")
      assert_includes result, 'Hello World'
    end

  end
end
