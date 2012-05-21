Feature: cpan_client should be able to install under not privileged user

Scenario: install cpan module
    * I run 'rm -rf /tmp/foo/'
    * it should exit '0'
    * a directory named '/tmp/foo/' should not exist
    * I run 'mkdir -p /tmp/foo/bar && chown melezhik -R /tmp/foo/ && chgrp melezhik -R /tmp/foo/'
    * it should exit '0'
    * a directory named '/tmp/foo/bar/' should exist
    * the file named '/tmp/foo/' should be owned by 'melezhik'
    * I run 'pm-uninstall -nf Bundler -l /tmp/foo/bar/'
    * it should exit '0'
    * I run 'eval $(perl -Mlocal::lib=/tmp/foo/bar/); perl -MBundler -e 1'
    * it should exit '2'
    * 'stderr' should have 'Can't locate Bundler\.pm'
    Given I have chef recipe:
    """
    cpan_client 'Bundler' do
        install_type 'cpan_module'
        user 'melezhik'
        group 'melezhik'
        action 'install'
        install_base 'bar'
        cwd '/tmp/foo/'
    end
    """
    When I run chef recipe on my node
    And I run 'eval $(perl -Mlocal::lib=/tmp/foo/bar/); perl -MBundler -e 1'
    Then it should exit '0'
    And the file named '/tmp/foo/bar/lib/perl5/' should be owned by 'melezhik'
    And the file named '/tmp/foo/bar/lib/perl5/Bundler.pm' should be owned by 'melezhik'

