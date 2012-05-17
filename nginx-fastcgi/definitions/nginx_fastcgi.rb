define :nginx_fastcgi do

    params[:servers].each do |s|
        s[:server_alias] ||= []
        s[:ssl_on] ||= false
        s[:port] ||= (s[:ssl_on] == true ? 443 : 80)
        if s[:server_name].nil? || s[:server_name].empty?
            message = 'you should setup server_name for your virtual host. '
            message << "virtual host string passed : #{s.inspect}"
            raise message
        end
    end
    
    template params[:name] do
        source 'nginx-site.erb'
        cookbook params[:cookbook] || 'nginx-fastcgi'
        variables({
            :servers => params[:servers],
            :site_name => params[:site_name]
        })
    end
end
