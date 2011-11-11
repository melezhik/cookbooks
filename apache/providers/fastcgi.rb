APACHE_VHOST_DIR = '/etc/apache2/vhosts.d/'

def load_current_resource
    @res = Chef::Resource::ApacheFastcgi.new(new_resource)
    @res.name(new_resource.name)
    @res.server_name(new_resource.server_name)
    @res.socket(new_resource.socket)
    @res.timeout(new_resource.timeout)
    @res.access_log(new_resource.access_log)
    @res.error_log(new_resource.error_log)
    @res.start_service(new_resource.start_service)
    check_input_params
end


action :install do

 server_name_attr = @res.server_name
 socket_attr = @res.socket
 timeout_attr = @res.timeout
 start_service_attr = @res.start_service

 access_log_attr = access_log
 error_log_attr = error_log
 virtual_file_attr = virtual_file
 
 service 'apache2'

 case node.platform # sorry for this case, but gentoo still not supported in apache2 cookbook
		    # http://tickets.opscode.com/browse/COOK-817
 when 'gentoo'
    template vhost_config_path do
	source 'fast-cgi-vhost.erb'
        variables(
           :params => {
	        :server_name => server_name_attr,
                :socket => socket_attr,
		:virtual_file => virtual_file_attr,
    	        :idle_timeout => timeout_attr,
		:access_log => access_log_attr,
        	:error_log => error_log_attr
           }
	)
        cookbook 'apache'
	notifies :restart, resources(:service =>'apache2') if start_service_attr == true
    end
  else 
    web_app vhost_id do # definition goes with apache2 cookbook, see OS supports there ((:
	template 'fast-cgi-vhost.erb'
	cookbook 'apache'
	server_name server_name_attr
        socket socket_attr
	virtual_file virtual_file_attr
        idle_timeout timeout_attr
	access_log access_log_attr
        error_log  error_log_attr
    end      
 end
 
  
 new_resource.updated_by_last_action(true)
end


def vhost_config_path
 "#{APACHE_VHOST_DIR}#{vhost_id}.conf"
end

def virtual_file
 "/tmp/#{vhost_id}-application"
end

def access_log
 @res.access_log.nil? ? "#{node.apache.dir}/#{vhost_id}-access.log" : @res.access_log
end

def error_log
 @res.error_log.nil? ? "#{node.apache.dir}/#{vhost_id}-error.log" : @res.error_log
end

def check_input_params 
 [
  'socket', 'server_name',
 ].each  do |p|
   raise "#{p} - obligatory parameter" if @res.send(p).nil?
 end
end


def vhost_id
 id = @res.name
 id.gsub!(' ','-')
 id.chomp!
 id
end
