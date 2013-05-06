class PintoSpec < MiniTest::Chef::Spec

  describe 'installs pinto application' do
    it 'install pinto client' do
      assert_sh('pinto -h')
    end
  end
end
