Feature: cpan_client should be able to install cpan module into give install_base

Scenario: install cpan module
    * I run 'pm-uninstall -nf Bundler -l /tmp/'
    * it should exit '0'
    * I run 'rm -rf /tmp/foo/ /tmp/baz/'
    * it should exit '0'
    * I run 'perl -I /tmp/foo/lib -MBundler -e 1'
    * it should exit '2'
    * 'stderr' should have 'Can't locate Bundler\.pm'
    Given I have chef recipe:
    """
    cpan_client 'Bundler' do
        install_type 'cpan_module'
        user 'root'
        group 'root'
        action 'install'
        install_base '/tmp/'
        install_path ["lib=/tmp/foo/lib/","libdoc=/tmp/baz/man"]
    end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo/lib/Bundler.pm' should exist    
    Then a file named '/tmp/baz/man/Bundler.3pm' should exist    
    When I run 'perl -I /tmp/foo/lib -MBundler -e 1'
    Then it should exit '0'
    When I run 'perl -MBundler -e 1'
    Then it should exit '2'
    And 'stderr' should have 'Can't locate Bundler\.pm'

