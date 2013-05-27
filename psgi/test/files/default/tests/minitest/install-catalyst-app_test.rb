class PsgiSpec < MiniTest::Chef::Spec
  describe 'psgi_application action install' do
    it 'creates proper init script file' do
      file_path = "/tmp/psgi/catalyst/app#{node[:psgi][:install][:extention]}"  
      file(file_path).must_exist
      file(file_path).must_include "FOO='100' CATALYST_CONFIG=/home/user/app/MyApplication/app.conf CATALYST_DEBUG=1 PERL5LIB=$PERL5LIB:cpanlib/lib/perl5 /usr/local/bin/plackup  -s FCGI --listen /tmp/app_fcgi.socket -E deployment -a  /home/user/app/MyApplication/scripts/app.psgi --manager FCGI::ProcManager --proc_title my-app --path / --nproc 2"
    end
  end
end
