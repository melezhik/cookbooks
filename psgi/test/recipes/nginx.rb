package 'nginx'

template '/etc/nginx/sites-available/app.conf' do
    source 'app.conf'
    owner 'root'
    group 'root'
    mode '644'
end

link '/etc/nginx/sites-enabled/app.conf' do
    to '/etc/nginx/sites-available/app.conf'
end

service 'nginx' do
  action :restart
end