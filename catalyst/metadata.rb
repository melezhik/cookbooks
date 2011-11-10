maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "catalyst application resource provider (LWRP)"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.32"
%w{ gentoo ubuntu }.each do |os|
  supports os
end
