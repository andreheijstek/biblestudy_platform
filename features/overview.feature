Feature: Is it coworkday today?

  Background: Planned cowork dates
    Given the following dates are planned as cowork dates: '2019-02-20', '2019-03-29', '2019-04-29'

  Scenario: If today is coworkday the page shows Yes
    Given "2019-03-29" is a coworkday
    When I go to "http://ishetalcoworkdag.com"
    Then the page shows "Ja"
#
  Scenario: If today is not coworkday the page shows No
    Given "2019-03-20" is a not coworkday
    When I go to "http://ishetalcoworkdag.com"
    Then the page shows "No"
#
