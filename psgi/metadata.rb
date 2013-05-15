maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "All rights reserved"
description      "Configures, runs psgi applications (as fastcgi standalone server)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.9"

%w{ ubuntu debian centos }.each do |os|
  supports os
end



