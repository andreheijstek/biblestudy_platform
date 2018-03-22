Feature: Viewing an overview of all studynotes
  In order find relevant bible interpretations
  As a bible student
  I want to see all studynotes in a nice structure

  Background: The following studies are stored
    Given I am logged in
    And there is a biblebook 'Jona' in the testament 'oud'
    And there is a biblebook 'Handelingen' in the testament 'nieuw'
    And there is a study on 'Jona'
    And there is a study on 'Handelingen'

  Scenario: View all studynotes ordered by testament
    Given
    When I look at the overview
    Then 'Oude Testament' should be shown before 'Nieuwe Testament'
    And 'Jona' should be shown before 'Handelingen'
