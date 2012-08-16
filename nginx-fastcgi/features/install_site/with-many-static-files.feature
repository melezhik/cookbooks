Feature: nginx-fastcgi should be able to set static files locations

Scenario: install nginx site config 
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            socket '/tmp/application.socket'
            static [
                {
                    :location => 'static/foo',
                    :root => '/var/www/foo'
                },
                {
                    :location => 'static/bar',
                    :root => '/var/www/bar'
                }
            ] 
            servers [
                {
                    :server_name => 'foo.site.x',
                }
            ]
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'root \/var\/www\/foo;'
    And a file named '/tmp/foo.site.conf' should contain 'root \/var\/www\/bar;'
    And a file named '/tmp/foo.site.conf' should contain 'root' only '2' times



