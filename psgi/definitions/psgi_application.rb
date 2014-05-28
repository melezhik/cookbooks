define :psgi_application, :cookbook => 'psgi', :server => 'FCGI', :environment => {}, :plackup_environment => 'development', :proc_manager => 'FCGI::ProcManager',  :perl5lib => [], :nproc => '1',  :debug => '1', :enable_service => 'on', :ignore_failure => true do 
    base_name = ::File.basename(params[:script].chomp ::File.extname(params[:script]))
    daemon_name = params[:daemon_name] ? params[:daemon_name] : base_name
    proc_title = params[:proc_title] ? params[:proc_title] : base_name

    socket = params[:socket] ? params[:socket] : "/tmp/#{base_name}_#{params[:server].downcase}.socket"


    if params[:action] == 'install'

        install_dir = params[:install_dir] || node[:psgi][:install][:dir]
        template "#{install_dir}/#{daemon_name}#{node[:psgi][:install][:extention]}" do 
            source 'init-script'
            cookbook params[:cookbook]
            variables({
                :application_user => params[:application_user],
                :application_home => params[:application_home],
                :application_script => params[:script],
                :application_desc => params[:name],
                :daemon_name => daemon_name,
                :daemon_path => params[:daemon_path] || `which plackup`.chomp,
                :socket => socket,
                :envvars => params[:environment],
                :perl5lib => params[:perl5lib],
                :nproc => params[:nproc],
                :proc_manager => params[:proc_manager] || ( params[:server] == 'FCGI' ? 'FCGI::ProcManager' : nil ),
                :proc_title => params[:proc_title] ||  ( params[:server] == 'FCGI' ? base_name : nil ) ,
                :mount => params[:mount],
                :config => params[:config],
                :debug => params[:debug],
                :plackup_environment => params[:plackup_environment],
                :install_dir => params[:install_dir],
                :operator => params[:operator] || 'default',
                :server => params[:server],
                :loader => params[:loader],
                :backlog => params[:backlog]
            })
            owner 'root'
            group 'root'
            mode '0755'
        end
        if params[:enable_service] == 'on'
            service daemon_name do 
                action :enable
                provider node[:psgi][:service][:provider]
            end
        end
    elsif params[:action] == 'test'

        my_test_env = Hash.new
        my_test_env['PERL5LIB'] = params[:perl5lib].join ':' unless params[:perl5lib].empty?

        if params[:server] == 'Twiggy'
            my_test_env['TWIGGY_DEBUG'] = '1'
        end

        unless params[:operator].nil?
            if params[:operator] == 'Catalyst'
                my_test_env['CATALYST_CONFIG'] = params[:config]
                my_test_env['CATALYST_DEBUG'] = '1'
            elsif params[:operator] == 'Dancer'
                my_test_env['DANCER_CONFDIR'] = params[:application_home]
            elsif params[:operator] == 'Jifty'
                my_test_env['JIFTY_CONFIG'] = params[:config]
            end
        end


        my_test_env['SERVER_PORT'] = '80'
        my_test_env['SCRIPT_NAME'] = '/'
        my_test_env['REQUEST_METHOD'] = 'GET'

        my_env = params[:environment].clone
        
        log "execute in pwd: #{params[:application_home]}"
        log "execute with env: #{my_test_env}"
        daemon_path = params[:daemon_path] || `which plackup`.chomp
        log "daemon_path: #{daemon_path}"
        execute "#{daemon_path} -s CGI #{params[:script]}" do 
            environment my_test_env.merge my_env
            cwd params[:application_home]
            user params[:application_user]
            group params[:application_group]
            ignore_failure params[:ignore_failure]
        end
    end
end

