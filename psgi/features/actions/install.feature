Feature: psgi_application should be able to install psgi init scripts 

Scenario: install 
    When I run 'rm -rf /tmp/psgi/ && mkdir /tmp/psgi/'
    Then it should exit '0'
    Given I have chef recipe:
    """
    psgi_application 'my application' do
        operator            'Catalyst'
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/app.psgi'
        daemon_name     'app'
        socket          '/tmp/app-socket.fcgi'
        environment({ "FOO" => "100" })
        perl5lib        [ 'cpanlib/lib/perl5' ]
        nproc           2
        proc_manager    'Adriver::FCGI::ProcManager'
        proc_title      'my-app'
        mount           '/'
        config          '/home/user/app/MyApplication/app.conf'
        debug           1
        plackup_environment 'deployment'
        install_dir '/tmp/psgi'
        action      'install'      
    end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/psgi/app' should exist
    And a file named '/tmp/psgi/app' should contain 'CATALYST_CONFIG'
    And a file named '/tmp/psgi/app' should contain 'APPLICATION_USER=user'
    And a file named '/tmp/psgi/app' should contain 'APPLICATION_HOME=/home/user/app/MyApplication'
    And a file named '/tmp/psgi/app' should contain 'PERL5LIB="cpanlib/lib/perl5"'
    And a file named '/tmp/psgi/app' should contain 'ENVVARS=\WFOO=100\W'
    And a file named '/tmp/psgi/app' should contain '--nproc\s+2'
    And a file named '/tmp/psgi/app' should contain '--manager\s+Adriver::FCGI::ProcManager'
    And a file named '/tmp/psgi/app' should contain '--proc-title=\Wmy-app\W'
    And a file named '/tmp/psgi/app' should contain 'mount\s+\\"\/\\"\s+'
    And a file named '/tmp/psgi/app' should contain 'my \\\$app = do \\"/home/user/app/MyApplication/scripts/app.psgi'
    And a file named '/tmp/psgi/app' should contain 'CATALYST_DEBUG=1'
    And a file named '/tmp/psgi/app' should contain 'CATALYST_CONFIG=/home/user/app/MyApplication/app.conf'
    And a file named '/tmp/psgi/app' should contain '\W-E\s+deployment'
    And a file named '/tmp/psgi/app' should contain 'NAME="app"'
    And a file named '/tmp/psgi/app' should contain 'SCRIPTNAME=/tmp/psgi/\$NAME'
        
