Given /^I have chef recipe:$/ do |resource|
 resource.gsub! "'", '"'
 `(echo 'recipe'; echo '#{resource}'; echo 'run_chef' ) > #{cache_dir}/shef.cmd`
end

Given /^I run chef recipe on my node$/ do
 cmd = "cat #{cache_dir}/shef.cmd | "
  
 if before_cmd.nil? 
    cmd << "shef -z -c ~/etc/chef/client.rb" 
 else
    cmd << "(#{before_cmd}; shef -z -c ~/etc/chef/client.rb)"
 end
 
 puts cmd if ENV['debug']

 step "I run '#{cmd}'"
end

Given /^I run command (.*) on my node$/ do |cmd|
  set_before_cmd cmd
end

Then /^web_application resource should have following parameters:$/ do |table|
    table.hashes.each do |row|
        k = row['Name']
        v = row['Value']
        step "'stdout' should have '#{k}:\"#{v}\"'"
    end
end
