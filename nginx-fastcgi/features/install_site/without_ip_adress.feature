Feature: nginx-fastcgi should be able to install nginx site config without ip adress

Backgound: delete old configs
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist

Scenario: install nginx site config, without ip adress
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :server_name => 'foo.site.x'
                }
            ]
            socket '/tmp/application.socket'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'listen 80;'

Scenario: install nginx https site config, without ip adress
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
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
    And a file named '/tmp/foo.site.conf' should contain 'listen 443;'

