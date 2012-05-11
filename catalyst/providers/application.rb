def load_current_resource
 
 @resource = Chef::Resource::CatalystApplication.new(new_resource.name)
 @resource.application_home(new_resource.application_home)
 @resource.application_script(new_resource.application_script)
 @resource.application_user(new_resource.application_user)
 @resource.application_group(new_resource.application_group)
 @resource.catalyst_config(new_resource.catalyst_config)
 @resource.perl5lib(new_resource.perl5lib)
 @resource.envvars(new_resource.envvars)
 @resource.socket(new_resource.socket)
 @resource.nproc(new_resource.nproc)
 @resource.proc_manager(new_resource.proc_manager)
 @resource.start_service(new_resource.start_service)
 
 check_input_params
 
end


action :install do

 if node.platform == 'gentoo' # special case for gentoo
     template '/etc/init.d/catalyst_application' do
	source 'catalyst_application'
	mode '0775'
        cookbook 'catalyst'
     action :create_if_missing
    end
    link "/etc/init.d/#{service_name}"  do
       to '/etc/init.d/catalyst_application'
    end
 end
 install_confd_template 
 new_resource.updated_by_last_action(true)
end


def install_confd_template 

 application_home = @resource.application_home
 application_script = @resource.application_script
 application_user = @resource.application_user
 application_group = @resource.application_group
 catalyst_config = @resource.catalyst_config
 perl5lib = @resource.perl5lib
 envvars = @resource.envvars
 socket = @resource.socket
 nproc = @resource.nproc
 proc_manager = @resource.proc_manager
 start_service = @resource.start_service
 
 service service_name do
    action :enable
 end

 template "#{node.catalyst.initscript.template.dir}/#{service_name}" do
  source   'catalyst_application.erb'
  cookbook 'catalyst'
  variables(
    :service_name     => service_name,
    :application_home => application_home,
    :application_user => application_user,
    :application_script => application_script,
    :catalyst_config => catalyst_config,
    :perl5lib => perl5lib,
    :envvars => envvars,
    :socket => socket,
    :nproc => nproc,
    :proc_manager => proc_manager
  )
  mode node.catalyst.initscript.template.mode
  notifies :restart, resources( :service => service_name ) unless start_service == false
 end 

 # start for first time
 if start_service == true
     service service_name do
      action 'start'
     end
 end

end


def service_name
 @resource.name
end

def check_input_params 
 [
  'application_home', 'application_user', 'application_group',
  'application_script', 'catalyst_config'
 ].each  do |p|
   raise "#{p} - obligatory parameter" if @resource.send(p).nil?
 end
end
