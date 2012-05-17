Feature: nginx-fastcgi должен уметь валидировать входные параметры 

Scenario: установить nginx сайт без server_name
    Given I run 'rm -rf /tmp/foo.site.conf'
    Then a file named '/tmp/foo.site.conf' should not exist
    And I have chef recipe:
    """
        nginx_fastcgi '/tmp/foo.site.conf' do
            site_name 'foo.site.x'
            servers [
                {
                    :ip => '127.0.0.1'
                }
            ]
        end
    """
    When I run chef recipe on my node
    Then 'stdout' should have 'RuntimeError: you should setup server_name for your virtual host'
    Then a file named '/tmp/foo.site.conf' should not exist

