directory '/tmp/local-lib/' do
  action :delete
  recursive true 
end

directory '/tmp/local-lib/' do
  action :create
  mode '0777'
end

directory '/tmp/local-lib/install' do
  action :create
  mode '0777'
end


