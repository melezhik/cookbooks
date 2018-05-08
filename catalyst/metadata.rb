name             "catalyst" 
maintainer       "melezhik"
maintainer_email "melezhik@gmail.com"
license          'Apache-2.0'
description      "catalyst application resource provider (LWRP)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
%w{ gentoo ubuntu debian}.each do |os|
  supports os
end
