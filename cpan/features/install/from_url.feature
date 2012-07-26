Feature: cpan_client should be able to install cpan module downloaded from http url 

Scenario: install cpan module
    * I run 'pm-uninstall -nf Bundler'
    * it should exit '0'
    * I run 'perl -MBundler -e 1'
    * it should exit '2'
    * 'stderr' should have 'Can't locate Bundler\.pm'
    Given I have chef recipe:
    """
    cpan_client 'http://search.cpan.org/CPAN/authors/id/M/ME/MELEZHIK/Bundler-v0.0.30.tar.gz' do
        install_type 'cpan_module'
        user 'root'
        group 'root'
        action 'install'
    end
    """
    When I run chef recipe on my node
    And I run 'perl -MBundler -e 1'
    Then it should exit '0'

