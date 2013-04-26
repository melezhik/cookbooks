require 'cucumber/nagios/steps'
module KnownsDomain
 def set_before_cmd cmd 
    @cmd = cmd
 end
 def before_cmd
    @cmd
 end
end

World KnownsDomain
