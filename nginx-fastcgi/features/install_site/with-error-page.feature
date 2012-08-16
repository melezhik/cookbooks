Feature: nginx-fastcgi should be able to set error_page parameter

Scenario: install nginx site config with error_page
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            servers [
                {
                    :server_name => 'foo.site.x'
                }
            ]
            socket '/tmp/application.socket'
            error_page [
                {
                    :code => 400,
                    :handler => '/400.html'
                },
                {
                    :code => 500,
                    :handler => '/500.html'
                }
            ]
        end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/foo.site.conf' should exist
    And a file named '/tmp/foo.site.conf' should contain 'error_page 400 /400.html;'
    And a file named '/tmp/foo.site.conf' should contain 'error_page 500 /500.html;'


