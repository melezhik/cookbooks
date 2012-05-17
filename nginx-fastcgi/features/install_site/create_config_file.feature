Feature: nginx-fastcgi should be able to install nginx site config

Scenario: install nginx site config
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :ip => '127.0.0.1',
                    :server_name => 'foo.site.x'
                }
            ]
            socket '/tmp/application.socket'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist

