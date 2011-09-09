DESCRIPTION
===========
run [chef templates](http://wiki.opscode.com/display/chef/Resources#Resources-Template) in dryrun mode
    
USAGE
=====

    include_recipe 'dry-run'

    dry_run_template "/home/user/file.conf" do
        source    "file.erb"
        mode '0644'
        owner 'root'
        group 'root'
    end

PARAMETERS
==========
well, this is [chef definition](http://wiki.opscode.com/display/chef/Definitions) so you can pass some
parametes here:

* `source`
* `mode`
* `owner`
* `group`

see explanations for them in http://wiki.opscode.com/display/chef/Resources#Resources-Template

    
