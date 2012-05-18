Feature: cpan_client should be able to install module by version

Scenario: install cpan module
    * I run 'pm-uninstall -nf Bundler'
    * it should exit '0'
    * I run 'perl -MBundler -e 1'
    * it should exit '2'
    * 'stderr' should have 'Can't locate Bundler\.pm'
    Given I have chef recipe:
    """
    cpan_client 'Bundler' do
        install_type 'cpan_module'
        user 'root'
        group 'root'
        action 'install'
    end
    """
    When I run chef recipe on my node
    And I run 'perl -MBundler -e 1'
    Then it should exit '0'

    Given I have chef recipe:
    """
    cpan_client 'Bundler' do
        install_type 'cpan_module'
        user 'root'
        group 'root'
        version '0.0.29'
        action 'install'
    end
    """
    When I run chef recipe on my node
    Then 'stdout' should have 'have higher or equal version \[v0\.0\.30\]' 
    And I run 'perl -MBundler -e 1'
    Then it should exit '0'

