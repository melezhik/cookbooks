class PsgiSpec < MiniTest::Chef::Spec

  describe 'installs and runs psgi application as starman server' do

    it 'creates init script file' do
      file("/etc/init.d/twiggy-psgi").must_exist
      file("/etc/init.d/twiggy-psgi").must_have(:owner,"root")
      file("/etc/init.d/twiggy-psgi").must_have(:group,"root")
      file("/etc/init.d/twiggy-psgi").must_have(:mode,"755")
    end

    it 'CGI script returns 200 OK and Hello World' do
      result = assert_sh("sudo bash -c 'cd /tmp/psgi/twiggy && SERVER_PORT=80 SERVER_NAME=127.0.0.1 SCRIPT_NAME=/ REQUEST_METHOD=GET plackup -s CGI app.psgi'")
      assert_includes result, 'Status: 200'
      assert_includes result, 'Hello World'
    end

    it 'runs server' do

      result = assert_sh('sudo /etc/init.d/twiggy-psgi status')
      assert_includes result, 'running'

      result = assert_sh('ps uax |  grep `cat /var/run/twiggy-psgi.pid`  | grep -v grep | wc -l')
      assert_includes result, '1'

      result = assert_sh('ps uax |  grep `cat /var/run/twiggy-psgi.pid`  | grep -v grep ')
      assert_includes result, 'app'
      assert_includes result, 'plackup'

    end

    it 'multiple start should not increase number of child process'do
      (1..3).each do |i|
        assert('/etc/init.d/twiggy-psgi start')
      end
      result = assert_sh('ps uax |  grep `cat /var/run/twiggy-psgi.pid`  | grep -v grep | wc -l')
      assert_includes result, '1'
    end

    it 'application index page returns Hello World' do
      result = assert_sh("curl 127.0.0.1:5001")
      assert_includes result, 'Hello World'
    end

  end
end
