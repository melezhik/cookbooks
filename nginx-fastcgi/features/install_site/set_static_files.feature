Feature: nginx-fastcgi should be able to configure `static' files to be handled by nginx, not application

Scenario: install nginx site config with static files
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :ip => '127.0.0.1',
                    :server_name => 'foo.site.x',
                    :static => [
                        {
                            :location => 'static/',
                            :root => '/var/www/MyApp/root'
                        }
                    ]
                }
            ]
            socket '/tmp/application.socket'
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'location static/'
    And a file named '/tmp/foo.site.conf' should contain 'root /var/www/MyApp/root;'
    And a file named '/tmp/foo.site.conf' should contain '1s;' only '2' times

