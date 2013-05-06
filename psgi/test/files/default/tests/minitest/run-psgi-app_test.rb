class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates init script file' do
      file("/etc/init.d/test").must_exist
    end

    it 'creates init script file with proper owner' do
      file("/etc/init.d/test").must_have(:owner,"root")
    end

    it 'creates init script file with proper group' do
      file("/etc/init.d/test").must_have(:group,"root")
    end

    it 'creates init script file with proper mode' do
      file("/etc/init.d/test").must_have(:mode,"755")
    end

    it 'init script returns successfull status' do
      result = assert_sh('sudo /etc/init.d/app status')
      assert_includes result, 'running'
    end

    it 'CGI script returns 200 OK and Hello World' do
      result = assert_sh("sudo bash -c 'cd /tmp/app && SERVER_PORT=80 SERVER_NAME=127.0.0.1 SCRIPT_NAME=/ REQUEST_METHOD=GET plackup -s CGI app.psgi'")
      assert_includes result, '200 OK'
      assert_includes result, 'Hello World'
    end
    it 'service app is up'do
      service("app").must_be_running
    end
  end
end
