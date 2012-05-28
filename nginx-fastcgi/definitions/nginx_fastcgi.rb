define :nginx_fastcgi do

    if params[:socket].nil? || params[:socket].empty?
        message = 'you should setup socket param. '
        raise message
    end

    params[:servers].each do |s|
        s[:server_alias] ||= []
        s[:ssl] ||= false
        s[:port] ||= (s[:ssl] == true ? 443 : 80)
        s[:location] ||= '/'

        if s[:server_name].nil? || s[:server_name].empty?
            message = 'you should setup server_name for your virtual host. '
            message << "virtual host string passed : #{s.inspect}"
            raise message
        end
        if s[:ssl] == true and ( s[:ssl_include_path].nil? || s[:ssl_include_path].empty? )
            message = 'you should setup ssl_include_path for your virtual host. '
            message << "virtual host string passed : #{s.inspect}"
            raise message
        end
        s[:static] ||= []
    end

    template params[:name] do
        source 'nginx-site.erb'
        cookbook params[:cookbook] || 'nginx-fastcgi'
        variables({
            :socket => params[:socket],
            :servers => params[:servers] || [],
            :site_name => File.basename(params[:name]).chomp(File.extname(params[:name]))
        })
    end
end
