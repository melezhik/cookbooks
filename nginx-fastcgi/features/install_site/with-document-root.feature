Feature: nginx-fastcgi should be able to set document root

Scenario: install nginx site config 
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :server_name => 'foo.site.x',
                }
            ]
            socket '/tmp/application.socket'
            root '/var/www/foo/bar/baz/'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'root \/var\/www\/foo\/bar\/baz\/;'



