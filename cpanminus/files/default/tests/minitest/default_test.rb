class Cpanminus::Spec < Chef::MiniTest::Spec
    describe 'installs cpanminus client' do
      it 'installs cpanm script' do
          assert_sh('cpanm')
      end
    end
end
