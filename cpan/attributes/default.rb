default.cpan_client.bootstrap.packages = ['curl']

case platform
when 'centos'
    default.cpan_client.bootstrap.packages << 'perl-devel'
    default.cpan_client.bootstrap.packages << 'perl-CPAN'
end

default.cpan_client.bootstrap.cpan_packages = ['Time::HiRes', 'CPAN', 'local::lib', 'App::pmuninstall']

default.cpan_client.default_inc = []


