DESCRIPTION
===========

  local::lib provider -- install application / cpan module via local::lib
  
REQUIREMENTS
============

  local::lib
  CPAN
  Module::Build 

ATTRIBUTES
==========

USAGE
=====

hello world example:

    include_recipe 'local_lib'
    
    local_lib_install 'CGI' do
	action 'install'
	      install_type 'cpan_module'
	      user 'root'
	      group 'root'
        end


