Given /^I have chef recipe:$/ do |resource|
 resource.gsub! "'", '"'
 `(echo 'recipe'; echo '#{resource}'; echo 'run_chef' ) > #{cache_dir}/shef.cmd`
end

Given /^I run chef recipe on my node$/ do
 cmd = "cat #{cache_dir}/shef.cmd | "
  
 if before_cmd.nil? 
    cmd << "shef -z -c #{ENV['chef_config']}" 
 else
    cmd << "(#{before_cmd}; shef -z #{ENV['chef_config']})"
 end
 
 puts cmd if ENV['debug']

 step "I run '#{cmd}'"
end

Given /^I run command (.*) on my node$/ do |cmd|
  set_before_cmd cmd
end

