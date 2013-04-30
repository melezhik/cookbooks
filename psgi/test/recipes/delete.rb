directory '/tmp/psgi' do
    action :delete
    recursive true
end

directory '/tmp/psgi' do
    action :create
end
