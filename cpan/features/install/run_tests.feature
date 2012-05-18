Feature: cpan_client should be able to run test against cpan module

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
        action 'test'
    end
    """
    When I run chef recipe on my node
    Then 'stderr' should have 'don\*t install, run tests only'
    Then 'stdout' should have '\./Build test -- OK'
    And I run 'perl -MBundler -e 1'
    Then it should exit '2'
    And 'stderr' should have 'Can't locate Bundler\.pm'

