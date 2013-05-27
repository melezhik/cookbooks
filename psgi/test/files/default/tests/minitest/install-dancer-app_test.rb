class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file_path = "/tmp/psgi/dancer/app#{node[:psgi][:install][:extention]}"  
      file(file_path).must_exist
      file(file_path).must_include 'DANCER_CONFDIR=/home/user/app/MyApplication'
    end
  end
end
