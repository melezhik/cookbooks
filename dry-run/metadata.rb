maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "Apache 2.0"
description      "dry runnable recipes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

%w{ ubuntu gentoo }.each do |os|
  supports os
end

