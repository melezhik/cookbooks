Feature: psgi_application should be able to install psgi init scripts with default parameters

Scenario: install with default parameters
    When I run 'rm -rf /tmp/psgi/ && mkdir /tmp/psgi/'
    Then it should exit '0'
    Given I have chef recipe:
    """
    psgi_application 'my application' do
        application_user    'user'
        application_home    '/home/user/app/MyApplication'
        script              '/home/user/app/MyApplication/scripts/foo.psgi'
        config              '/home/user/app/MyApplication/app.conf'
        install_dir         '/tmp/psgi'
        action              'install'      
    end
    """
    When I run chef recipe on my node
    Then a file named '/tmp/psgi/foo' should exist
    # default operator is Catalyst
    And a file named '/tmp/psgi/foo' should contain 'CATALYST_CONFIG' 
    # default perl5lib is []
    And a file named '/tmp/psgi/foo' should contain 'PERL5LIB=' only '1' times
    # default environment is {}
    And a file named '/tmp/psgi/foo' should contain 'ENVVARS=\W\W'
    # default nproc
    And a file named '/tmp/psgi/foo' should contain '--nproc\s+1'
    # And a file named '/tmp/psgi/foo' should contain '--manager\s+Adriver::FCGI::ProcManager'
    # default proc-title
    And a file named '/tmp/psgi/foo' should contain '--proc-title=\Wfoo\W'
    # default socket
    And a file named '/tmp/psgi/foo' should contain '--listen\s+/tmp/foo_fcgi.socket'
    # default debug
    And a file named '/tmp/psgi/foo' should contain 'CATALYST_DEBUG=1'
    # default plackup environment
    And a file named '/tmp/psgi/foo' should contain '\W-E\s+development'
    # default name
    And a file named '/tmp/psgi/foo' should contain 'NAME="foo"'
    # default install dir
    And a file named '/tmp/psgi/foo' should contain 'SCRIPTNAME=/tmp/psgi/\$NAME'
    
