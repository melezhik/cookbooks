Given /^I have chef recipe:$/ do |resource|
 resource.gsub! "'", '"'
 `echo '#{resource}' > psgi/recipes/test.rb`
end

Given /^I run chef recipe on my node$/ do
  
 if before_cmd.nil? 
    cmd = 'chef-solo -c solo.rb -o psgi::test'
 else
    cmd = "#{before_cmd}; chef-solo -c solo.rb -o psgi::test"
 end
 
 puts cmd if ENV['debug']

 step "I run '#{cmd}'"
end

Given /^I run command (.*) on my node$/ do |cmd|
  set_before_cmd cmd
end

