name             'cpanminus'
maintainer       'Alexey Melezhik'
maintainer_email 'melezhik@gmail.com'
license          'All rights reserved'
description      'Installs cpanminus client'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{ ubuntu debian centos }.each do |os|
  supports os
end
