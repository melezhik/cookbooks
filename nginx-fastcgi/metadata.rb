maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "All rights reserved"
description      "create nginx site to run your fastcgi application under nginx frontend"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

%w{ ubuntu debian }.each do |os|
  supports os
end

