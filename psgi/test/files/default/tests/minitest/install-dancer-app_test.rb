class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file_path = "/tmp/psgi/dancer/app#{node[:psgi][:install][:extention]}"  
      file(file_path).must_exist
      file(file_path).must_include 'DANCER_CONFDIR=/home/user/app/MyApplication /usr/local/bin/plackup  -s FCGI --listen /tmp/app_fcgi.socket -E development -a  /home/user/app/MyApplication/scripts/app.psgi --manager FCGI::ProcManager --proc_title app --path / --nproc 1'
    end
  end
end
