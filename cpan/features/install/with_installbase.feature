Feature: cpan_client should be able to install cpan module into give install_base

Scenario: install cpan module
    * I run 'pm-uninstall -nf Bundler -l /tmp/'
    * it should exit '0'
    * I run 'eval $(perl -Mlocal::lib=/tmp/); perl -MBundler -e 1'
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
    end
    """
    When I run chef recipe on my node
    And I run 'eval $(perl -Mlocal::lib=/tmp/); perl -MBundler -e 1'
    Then it should exit '0'
    And I run 'perl -MBundler -e 1'
    Then it should exit '2'
    And 'stderr' should have 'Can't locate Bundler\.pm'

