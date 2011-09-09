DESCRIPTION
===========
  - run [chef tempaltes](http://wiki.opscode.com/display/chef/Resources#Resources-Template) in dryrun mode
    
USAGE
=====

    include_recipe 'dry-run'

    dry_run_template "/home/user/file.conf" do
	source    "file.erb"
	mode '0644'
	owner 'root'
	group 'root'
    end
    
