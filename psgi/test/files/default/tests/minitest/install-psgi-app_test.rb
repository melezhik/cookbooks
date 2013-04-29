require File.expand_path('../support/helpers', __FILE__)
describe 'install psgi application' do
  include Helpers::Test
  # Example spec tests can be found at http://git.io/Fahwsw
  it 'install init script' do
    file("/tmp/psgi/app").must_exist
  end
end
