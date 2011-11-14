maintainer       "Alexey Melezhik"
maintainer_email "melezhik@gmail.com"
license          "Apache 2.0"
description      "run chef templates in dryrun mode"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

%w{ ubuntu gentoo }.each do |os|
  supports os
end

