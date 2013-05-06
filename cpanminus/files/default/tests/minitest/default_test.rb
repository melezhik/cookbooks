class CpanMinusSpec < MiniTest::Chef::Spec
    describe 'installs cpanminus client' do
      it 'installs cpanm script' do
          result = assert_sh('cpanm --version')
          assert_includes result, 'App::cpanminus'
      end
    end
end
