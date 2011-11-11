catalyst_application node.catalyst_fastcgi.service_name do
 application_user node.catalyst_fastcgi.application.user
 application_group node.catalyst_fastcgi.application.group
 application_home node.catalyst_fastcgi.application.home
 application_script node.catalyst_fastcgi.application.script
 catalyst_config node.catalyst_fastcgi.catalyst_config
 socket node.catalyst_fastcgi.socket
 envvars node.catalyst_fastcgi.envvars
 perl5lib node.catalyst_fastcgi.application.perl5lib
 nproc node.catalyst_fastcgi.nproc
 proc_manager node.catalyst_fastcgi.proc_manager
 start_service node.catalyst_fastcgi.start_service
 action 'install'
end

apache_fastcgi node.catalyst_fastcgi.service_name do
 server_name node.catalyst_fastcgi.server_name
 socket node.catalyst_fastcgi.socket
 action 'install'
end

