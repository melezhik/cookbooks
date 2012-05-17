Feature: nginx-fastcgi should create proper log/error_log files paths

Scenario: install nginx site config
    Given I run 'rm -rf /tmp/my.site.conf'
    Then a file named '/tmp/my.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/my.site.conf' do
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
    Then a file named '/tmp/my.site.conf' should exist
    And a file named '/tmp/my.site.conf' should contain 'access_log /var/log/nginx/my.site.access.log;'
    And a file named '/tmp/my.site.conf' should contain 'error_log  /var/log/nginx/my.site.error.log;'    
