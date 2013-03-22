require 'cucumber/nagios/steps'

module KnownsDomain
 
 CACHE_DIR = '/tmp/cucumber/shef/psgi/cache'
 def cache_dir 
    CACHE_DIR
 end
 
 def set_before_cmd cmd 
    @cmd = cmd
 end
 
 def before_cmd
    @cmd
 end
 
end

World KnownsDomain

`mkdir -p #{KnownsDomain::CACHE_DIR}`
