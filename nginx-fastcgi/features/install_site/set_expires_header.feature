Feature: nginx-fastcgi should be able to set expires header in installed site config

Scenario: install nginx site config, expires is '30d'
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
            expires '30d'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'listen 127.0.0.1:80;'
    And a file named '/tmp/foo.site.conf' should contain 'expires 30d;'

