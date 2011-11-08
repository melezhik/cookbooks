actions :install
attribute :application_home, :kind_of => String
attribute :application_user, :kind_of => String
attribute :application_group, :kind_of => String
attribute :application_script, :kind_of => String
attribute :catalyst_config, :kind_of => String
attribute :perl5lib, :kind_of => Array, :default => []
attribute :envvars, :kind_of => Hash, :default => {}
attribute :socket, :kind_of => String
attribute :nproc, :kind_of => Integer, :default => 1
attribute :proc_manager, :kind_of => String, :default => 'FCGI::ProcManager'

