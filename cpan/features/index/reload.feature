Feature: cpan_client should be able to reload cpan index

Scenario: reload cpan index
    Given I have chef recipe:
    """
    cpan_client 'index reload' do
        install_type 'cpan_module'
        user 'root'
        group 'root'
        action 'reload_cpan_index'
    end
    """
    When I run chef recipe on my node
    Then 'stderr' should have 'reload cpan index'
    And it should exit '0'
    And the mtime of '/root/.cpan/sources/modules/02packages.details.txt.gz' should be different

