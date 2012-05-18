Feature: Workaround for strange Segmentation fault bug of cucumber-nagios

Scenario: just meaningless command

    When I run 'echo 100'
    Then 'stdout' should have '100'

