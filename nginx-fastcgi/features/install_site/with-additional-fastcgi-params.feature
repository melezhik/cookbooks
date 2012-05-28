Feature: nginx-fastcgi should be able to set additional fastcgi params

Scenario: install nginx site config 
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            socket '/tmp/application.socket'
            fastcgi_param  [
                { :name => 'SCRIPT_NAME', :value => "\"\"" },
                { :name => 'PATH_INFO' , :value => '$uri' }
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
    And a file named '/tmp/foo.site.conf' should contain 'fastcgi_param SCRIPT_NAME "";'



