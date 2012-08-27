actions :install, :test, :reload_cpan_index
attribute :cpan_home, :kind_of => String
attribute :cwd , :kind_of => String, :default => '/tmp/'
attribute :dry_run, :kind_of => [TrueClass, FalseClass], :default => false
attribute :environment , :kind_of => Hash, :default => Hash.new
attribute :force, :kind_of => [TrueClass, FalseClass], :default => false
attribute :from_cookbook, :kind_of => String
attribute :group , :kind_of => String
attribute :inc, :default => [], :kind_of => Array
attribute :install_base, :kind_of => String
attribute :install_path, :default => [], :kind_of => Array
attribute :install_type, :kind_of => String, :default => 'application'
attribute :module_name , :kind_of => String
attribute :name , :kind_of => String
attribute :reload_cpan_index, :kind_of => [TrueClass, FalseClass], :default => false
attribute :user , :kind_of => String
attribute :version , :kind_of => String

