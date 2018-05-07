maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          'Apache-2.0'
description      "1) Configures catalyst as fastcgi server 2) Configure apache virtual host for it"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"
depends          "catalyst", ">= 0.0.4"
depends          "apache" , ">= 0.0.3"






