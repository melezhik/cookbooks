Feature: nginx-fastcgi should be able to apply default settings 

Backgound: delete old configs
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist

Scenario: install nginx site config, default port is 80
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
    And a file named '/tmp/foo.site.conf' should contain 'listen 127.0.0.1:80;'

Scenario: install nginx ssl site config, default port is 443
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :ip => '127.0.0.1',
                    :server_name => 'foo.site.x',
                    :ssl => true,
                    :ssl_include_path => 'nginx_ssl_settings.conf'
                }
            ]
            socket '/tmp/application.socket'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    Then a file named '/tmp/foo.site.conf' should contain 'listen 127.0.0.1:443 ssl;'

