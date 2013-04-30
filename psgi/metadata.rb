maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "All rights reserved"
description      "Configures, runs psgi applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.7"

%w{ ubuntu debian centos }.each do |os|
  supports os
end


