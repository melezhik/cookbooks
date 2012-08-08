maintainer       "melezhik"
maintainer_email "melezhik@gmail.com"
license          "All rights reserved"
description      "catalyst application resource provider (LWRP)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.7"
%w{ gentoo ubuntu debian}.each do |os|
  supports os
end
