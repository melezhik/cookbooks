Feature: nginx-fastcgi should be able to set alternative fastcgi location

Scenario: install nginx site config 
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :ip => '127.0.0.1',
                    :server_name => 'foo.site.x',
                    :location => '=~ foo-bar '
                }
            ]
            socket '/tmp/application.socket'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'location =~ foo-bar'


