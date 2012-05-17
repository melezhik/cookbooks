maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "All rights reserved"
description      "configure nginx to operate with fastcgi application"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

%w{ ubuntu }.each do |os|
  supports os
end

