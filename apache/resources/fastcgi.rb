actions :install
attribute :server_name, :kind_of => String
attribute :socket, :kind_of => String
attribute :timeout, :kind_of => Integer, :default => 180
attribute :access_log, :kind_of => String
attribute :error_log, :kind_of => String
