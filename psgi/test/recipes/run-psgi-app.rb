directory '/tmp/app/' do
  action :delete
  recursive true
end

directory '/tmp/app/' do
  action :create
end


cookbook_file '/tmp/app/app.psgi' do
  source 'test.psgi'
end

cookbook_file '/tmp/app/app.conf' do
  source 'test.conf'
end

psgi_application 'my application' do
        operator            'Catalyst'
        enable_service      'off'
        application_user    'root'
        application_home    '/tmp/app/'
        script              '/tmp/app/app.psgi'
        config              '/tmp/app/app.conf'
        action              'install'
end

service 'app' do
  action :start
end




