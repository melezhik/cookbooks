Feature: psgi_application should be able to install psgi init scripts for Dancer applications

Scenario: install with default parameters
    When I run 'rm -rf /tmp/psgi/ && mkdir /tmp/psgi/'
    Then it should exit '0'
    Given I have chef recipe:
    """
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        install_dir         '/tmp/psgi'
        operator            'Dancer'
        action              'install'      
    end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/psgi/foo' should exist
    And a file named '/tmp/psgi/foo' should contain 'APPLICATION_HOME=/home/user/app/MyApplication'
    And a file named '/tmp/psgi/foo' should contain 'DANCER_CONFDIR="\$\{APPLICATION_HOME\}"'

