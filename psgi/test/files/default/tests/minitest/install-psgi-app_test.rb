require File.expand_path('../support/helpers', __FILE__)

describe 'psgi_application action install' do

  include Helpers::Test

  it 'creates init script file' do
    file("/tmp/psgi/app").must_exist
  end

  # Example spec tests can be found at http://git.io/Fahwsw
  # it 'install init script' { file("/tmp/psgi/app").must_exist }
  it 'add proper content into init script file' do
     file("/tmp/psgi/app").must_match /APPLICATION_USER=user/
  end

end

