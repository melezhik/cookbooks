APACHE_VHOST_DIR = '/etc/apache2/vhosts.d/'

def load_current_resource
    @res = Chef::Resource::ApacheFastcgi.new(new_resource)
    @res.name(new_resource.name)
    @res.server_name(new_resource.server_name)
    @res.socket(new_resource.socket)
    @res.timeout(new_resource.timeout)
    @res.access_log(new_resource.access_log)
    @res.error_log(new_resource.error_log)
    check_input_params
end


action :install do

 server_name = @res.server_name
 socket = @res.socket
 timeout = @res.timeout
 
 service 'apache2'

 template vhost_config_path do
    source 'fast-cgi-vhost.erb'
    variables(
       :server_name => server_name,
       :socket => socket,
       :virtual_file => virtual_file,
       :timeout => timeout,
       :access_log => access_log,
       :error_log => error_log
    )
    cookbook 'apache'
    notifies :restart, resources(:service =>'apache2')
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
 @res.access_log.nil? ? "/var/log/apache2/#{vhost_id}-access.log" : @res.access_log
end

def error_log 
 @res.error_log.nil? ? "/var/log/apache2/#{vhost_id}-error.log" : @res.error_log
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
