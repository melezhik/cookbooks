class PintoSpec < MiniTest::Chef::Spec

  describe 'installs pinto application' do
    it 'install pinto client' do
      result = assert_sh('pinto version')
      %w( App::Pinto Pinto Pinto::Remote).each do |l|
        assert_includes result, l
      end
      
    end
  end
end
