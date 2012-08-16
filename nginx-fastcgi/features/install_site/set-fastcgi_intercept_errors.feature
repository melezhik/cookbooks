Feature: nginx-fastcgi should be able to set additional fastcgi params

Scenario: install nginx site config 
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            socket '/tmp/application.socket'
            servers [
                {
                    :server_name => 'foo.site.x',
                }
            ]
            fastcgi_intercept_errors true
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'fastcgi_intercept_errors on;'



