maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "All rights reserved"
description      "installs, configures, runs psgi application as fastcgi server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

%w{ ubuntu debian }.each do |os|
  supports os
end

